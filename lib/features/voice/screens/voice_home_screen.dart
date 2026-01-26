import 'package:flutter/material.dart';
import '../services/voice_service.dart';

class VoiceHomeScreen extends StatefulWidget {
  const VoiceHomeScreen({super.key});

  @override
  State<VoiceHomeScreen> createState() => _VoiceHomeScreenState();
}

class _VoiceHomeScreenState extends State<VoiceHomeScreen> {
  final VoiceService _voiceService = VoiceService();

  String recognizedText = '';
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _initVoice();
  }

  Future<void> _initVoice() async {
    final locale = await _voiceService.getSystemLocale();
    await _voiceService.init(languageCode: locale);
  }

  Future<void> _startListening() async {
    setState(() => isListening = true);

    await _voiceService.startListening(
      localeId: await _voiceService.getSystemLocale(),
      onResult: (text) async {
        setState(() {
          recognizedText = text;
          isListening = false;
        });

        // ردّ بالصوت (تجربة أولى)
        await _voiceService.speak(
          'Vous avez dit: $text',
        );
      },
    );
  }

  Future<void> _stopListening() async {
    await _voiceService.stopListening();
    setState(() => isListening = false);
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commande vocale'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Parlez, je vous écoute',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Center(
                child: Text(
                  recognizedText.isEmpty
                      ? 'Appuyez sur le micro et parlez'
                      : recognizedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            FloatingActionButton(
              onPressed:
                  isListening ? _stopListening : _startListening,
              child: Icon(
                isListening ? Icons.stop : Icons.mic,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
