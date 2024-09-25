import 'package:bloc/bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zee_translator/app/cubit/speech_to_text_cubit/speech_to_text_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  SpeechCubit() : super(SpeechState.initial()) {
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    emit(state.copyWith(
        isSpeechEnabled: true, status: SpeechStatus.initialized));
  }

  Future<void> startListening() async {
    emit(state.copyWith(status: SpeechStatus.listening));
    if (_speechEnabled) {
      _speechToText.listen(
        onResult: (result) {
          print("Result....");
          emit(state.copyWith(status: SpeechStatus.result, result: result));
          _speechToText.stop();
          emit(state.copyWith(status: SpeechStatus.stopped));
        },
        listenFor: const Duration(seconds: 5),
        localeId: "en_US",
        cancelOnError: true,
        partialResults: false,
        listenMode: ListenMode.confirmation,
      );
    } else {
      emit(state.copyWith(status: SpeechStatus.error));
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    emit(state.copyWith(status: SpeechStatus.stopped));
  }

  Future<void> listenForPermissions() async {
    final status = await Permission.microphone.status;
    if (status.isDenied) {
      await requestForPermission();
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }
}
