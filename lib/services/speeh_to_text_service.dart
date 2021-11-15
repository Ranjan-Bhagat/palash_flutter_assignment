import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  static final _stt = SpeechToText();

  static Future<bool> toggleRecording({
      required Function(String text) onResult,
      required ValueChanged<bool> onListening
    }) async {
        final isAvaliable = await _stt.initialize(
          onStatus: (statu) => onListening(_stt.isListening),
          // onError: (e) => print('Error: $e')
        );

    if (isAvaliable) {
      if (_stt.isListening) {
        _stt.stop();
      } else {
        _stt.listen(onResult: (value) => onResult(value.recognizedWords));
      }
    }

    return isAvaliable;
  }
}
