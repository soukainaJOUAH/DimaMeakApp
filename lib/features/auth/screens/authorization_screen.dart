import 'package:flutter/material.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // 🔹 Title (فوق الصورة)
              const Text(
                'Autorisation\nd’accessibilité',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A3D91),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Illustration
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/images/authorization.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 16),

              // 🔹 Description
              const Text(
                'Dima Meak a besoin d’accéder au micro\net à la lecture vocale.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500, // ⬅️ semi-bold
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Permissions list
              const _PermissionItem(
                icon: Icons.volume_up,
                text:
                    'Conversion texte → parole\nÉcoutez le contenu à haute voix.',
              ),
              const SizedBox(height: 12),
              const _PermissionItem(
                icon: Icons.mic,
                text:
                    'Reconnaissance vocale\nParlez pour rechercher ou naviguer.',
              ),

              const Spacer(),

              // 🔹 Buttons
              Row(
                children: [
                  // 🔹 Refuser (كبرناه فقط)
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: refuser → login ou home
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF0E7C7B),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                            padding: const EdgeInsets.symmetric(vertical: 16), // ⬅️ كبّرناه
                            minimumSize: const Size(double.infinity, 48), // ⬅️ نفس ارتفاع Autoris
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

                  const SizedBox(width: 12),

                  // 🔹 Autoriser (ما تبدّل والو)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // TODO: autoriser → next screen
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

              const SizedBox(height: 24),
            ],
          ),
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
    final parts = text.split('\n'); // title + description

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF0E7C7B),
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Title (Bold)
              Text(
                parts[0],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600, // ⬅️ Bold
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 4),

              // 🔹 Description
              Text(
                parts.length > 1 ? parts[1] : '',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
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
