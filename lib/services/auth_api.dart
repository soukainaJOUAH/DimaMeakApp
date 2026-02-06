import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/enums/user_role.dart';

class AuthService {
	AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
			: _auth = auth ?? FirebaseAuth.instance,
				_firestore = firestore ?? FirebaseFirestore.instance;

	static Future<void>? _googleInit;

	final FirebaseAuth _auth;
	final FirebaseFirestore _firestore;

	User? get currentUser => _auth.currentUser;

	Future<UserCredential> signIn({
		required String email,
		required String password,
	}) {
		return _auth.signInWithEmailAndPassword(
			email: email.trim(),
			password: password,
		);
	}

	Future<void> sendPasswordReset({required String email}) {
		return _auth.sendPasswordResetEmail(email: email.trim());
	}

	Future<UserCredential> signInWithGoogle() async {
		if (kIsWeb) {
			final provider = GoogleAuthProvider();
			final cred = await _auth.signInWithPopup(provider);
			await _ensureUserProfile(cred.user, UserRole.utilisateur);
			return cred;
		}

		await _ensureGoogleInitialized();
		final googleUser = await _authenticateGoogleUser();
		final googleAuth = googleUser.authentication;
		final credential = GoogleAuthProvider.credential(
			accessToken: null,
			idToken: googleAuth.idToken,
		);
		final cred = await _auth.signInWithCredential(credential);
		await _ensureUserProfile(cred.user, UserRole.utilisateur);
		return cred;
	}

	Future<void> _ensureGoogleInitialized() async {
		_googleInit ??= GoogleSignIn.instance.initialize();
		await _googleInit;
	}

	Future<GoogleSignInAccount> _authenticateGoogleUser() async {
		try {
			return await GoogleSignIn.instance.authenticate();
		} on GoogleSignInException catch (e) {
			if (e.code == GoogleSignInExceptionCode.canceled ||
				e.code == GoogleSignInExceptionCode.interrupted) {
				throw FirebaseAuthException(
					code: 'sign-in-cancelled',
					message: 'Connexion Google annulée',
				);
			}
			rethrow;
		}
	}

	Future<UserCredential> registerWithEmail({
		required String email,
		required String password,
		required UserRole role,
		required Map<String, dynamic> profile,
	}) async {
		final cred = await _auth.createUserWithEmailAndPassword(
			email: email.trim(),
			password: password,
		);

		final uid = cred.user?.uid;
		if (uid == null) {
			throw FirebaseAuthException(
				code: 'user-creation-failed',
				message: 'Utilisateur non créé',
			);
		}

		await _firestore.collection('users').doc(uid).set({
			'email': email.trim(),
			'role': _roleToString(role),
			'createdAt': FieldValue.serverTimestamp(),
			...profile,
		}, SetOptions(merge: true));

		return cred;
	}

	Future<UserRole> fetchUserRole(String uid) async {
		final snap = await _firestore.collection('users').doc(uid).get();
		if (!snap.exists) {
			throw FirebaseAuthException(
				code: 'role-not-found',
				message: 'Profil utilisateur introuvable',
			);
		}
		final data = snap.data() ?? {};
		return _roleFromString(data['role']?.toString());
	}

	Future<void> _ensureUserProfile(User? user, UserRole defaultRole) async {
		if (user == null) return;
		final doc = _firestore.collection('users').doc(user.uid);
		final snap = await doc.get();
		if (snap.exists) return;

		await doc.set({
			'email': user.email,
			'role': _roleToString(defaultRole),
			'name': user.displayName,
			'photoUrl': user.photoURL,
			'createdAt': FieldValue.serverTimestamp(),
		}, SetOptions(merge: true));
	}

	String _roleToString(UserRole role) {
		switch (role) {
			case UserRole.aidant:
				return 'aidant';
			case UserRole.utilisateur:
				return 'utilisateur';
		}
	}

	UserRole _roleFromString(String? value) {
		if (value == 'aidant') return UserRole.aidant;
		return UserRole.utilisateur;
	}
}
