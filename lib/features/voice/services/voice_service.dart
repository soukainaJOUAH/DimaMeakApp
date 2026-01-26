import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool isListening = false;

  /// تهيئة الصوت (لغة + سرعة)
  Future<void> init({String? languageCode}) async {
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);

    if (languageCode != null) {
      await _tts.setLanguage(languageCode);
    }
  }

  /// بدأ الاستماع
  Future<void> startListening({
    required Function(String text) onResult,
    String? localeId,
  }) async {
    final available = await _speech.initialize();

    if (available) {
      isListening = true;

      _speech.listen(
        localeId: localeId,
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          }
        },
      );
    }
  }

  /// وقف الاستماع
  Future<void> stopListening() async {
    isListening = false;
    await _speech.stop();
  }

  /// التطبيق يهضر
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _tts.speak(text);
    }
  }

  /// لغة النظام (auto)
  Future<String?> getSystemLocale() async {
    final locale = await _speech.systemLocale();
    return locale?.localeId;
  }

  /// تنظيف
  void dispose() {
    _speech.cancel();
    _tts.stop();
  }
}
