import 'package:equatable/equatable.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

enum SpeechStatus { initial, initialized, listening, stopped, result ,error}

class SpeechState {
  final SpeechStatus status;
  final bool isSpeechEnabled;
  final SpeechRecognitionResult? result;

  SpeechState({
    required this.status,
    required this.isSpeechEnabled,
    required this.result,
  });

  // Factory constructor for the initial state
  factory SpeechState.initial() {
    return SpeechState(
      status: SpeechStatus.initial,
      isSpeechEnabled: false,
      result: null
    );
  }

  /*// Factory constructor for initialized state
  factory SpeechState.initialized(bool isSpeechEnabled) {
    return SpeechState(
      status: SpeechStatus.initialized,
      isSpeechEnabled: isSpeechEnabled,
    );
  }

  // Factory constructor for listening state
  factory SpeechState.listening() {
    return SpeechState(
      status: SpeechStatus.listening,
    );
  }

  // Factory constructor for stopped state
  factory SpeechState.stopped() {
    return SpeechState(
      status: SpeechStatus.stopped,
    );
  }

  // Factory constructor for result state
  factory SpeechState.result(SpeechRecognitionResult result) {
    return SpeechState(
      status: SpeechStatus.result,
      result: result,
    );
  }
*/
  // Method to copy and modify state
  SpeechState copyWith({
    SpeechStatus? status,
    bool? isSpeechEnabled,
    SpeechRecognitionResult? result,
  }) {
    return SpeechState(
      status: status ?? this.status,
      isSpeechEnabled: isSpeechEnabled ?? this.isSpeechEnabled,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [status, isSpeechEnabled, result];
}

