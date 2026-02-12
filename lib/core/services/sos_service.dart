import 'package:flutter/material.dart';

class SosService {
  SosService._();

  static final SosService instance = SosService._();

  final ValueNotifier<bool> enabled = ValueNotifier<bool>(false);
  final ValueNotifier<String> phoneNumber = ValueNotifier<String>('+212 6 00 00 00 00');

  void setEnabled(bool value) => enabled.value = value;

  void setPhoneNumber(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    phoneNumber.value = trimmed;
  }
}

class SosOverlay extends StatelessWidget {
  const SosOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SosService.instance.enabled,
      builder: (context, enabled, _) {
        if (!enabled) return const SizedBox.shrink();

        return Positioned(
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).padding.bottom + 64,
          child: Center(
            child: ValueListenableBuilder<String>(
              valueListenable: SosService.instance.phoneNumber,
              builder: (context, phone, __) {
                return Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => _showSosDialog(context, phone),
                    customBorder: const CircleBorder(),
                    child: Container(
                      height: 78,
                      width: 78,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE53935).withOpacity(0.35),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'SOS',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showSosDialog(BuildContext context, String phone) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Urgence'),
          content: Text('Appelez le numero: $phone'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}