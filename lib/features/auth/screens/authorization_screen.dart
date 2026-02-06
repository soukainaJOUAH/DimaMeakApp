import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dima_m3ak/features/home/screens/home_screen.dart';
import 'package:dima_m3ak/core/enums/user_role.dart';



class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),

                      // 🔹 Title
                      Text(
                        'Autorisation\nd’accessibilité',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.075,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0A3D91),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // 🔹 Illustration
                      Image.asset(
                        'assets/images/authorization.png',
                        height: size.height * 0.32,
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: size.height * 0.03),

                      // 🔹 Description
                      Text(
                        'Dima Meak a besoin d’accéder au micro\net à la lecture vocale.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.042,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // 🔹 Permissions list
                      const _PermissionItem(
                        icon: Icons.volume_up,
                        text:
                            'Conversion texte → parole\nÉcoutez le contenu à haute voix.',
                      ),

                      SizedBox(height: size.height * 0.025),

                      const _PermissionItem(
                        icon: Icons.mic,
                        text:
                            'Reconnaissance vocale\nParlez pour rechercher ou naviguer.',
                      ),

                      SizedBox(height: size.height * 0.06),

                      // 🔹 Buttons
                      Row(
                        children: [
                          // 🔹 Refuser
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(
                                        isVoiceEnabled: false,
                                        role: UserRole.utilisateur,
                                      ),
                                    ),
                                  );
                                },

                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF0E7C7B),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Refuser',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0E7C7B),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: size.width * 0.04),

                          // 🔹 Autoriser
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final status = await Permission.microphone.request();

                                if (status.isGranted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(
                                        isVoiceEnabled: true,
                                        role: UserRole.utilisateur,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Permission du micro refusée'),
                                    ),
                                  );
                                }
                              },

                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF0A3D91),
                                      Color(0xFF0E7C7B),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Autoriser',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 🔹 Permission item widget
class _PermissionItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PermissionItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final parts = text.split('\n');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF0E7C7B),
          size: size.width * 0.06,
        ),
        SizedBox(width: size.width * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                parts[0],
                style: TextStyle(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                parts.length > 1 ? parts[1] : '',
                style: TextStyle(
                  fontSize: size.width * 0.038,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
