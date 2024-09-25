import 'package:bloc/bloc.dart';
import 'package:translator/translator.dart';
import 'package:zee_translator/app/cubit/translator_cubit/translator_state.dart';

class TranslatorCubit extends Cubit<TranslatorState> {
  final translator = GoogleTranslator();

  TranslatorCubit() : super(TranslatorState.initial());

  Future<void> translate(String from, String to, String text) async {
    emit(state.copyWith(
        translatorStatus: TranslatorStatus.converting,
        message: 'Converting...'));
    try {
      await translator.translate(text, from: from, to: to).then((result) {
        emit(state.copyWith(
            translatorStatus: TranslatorStatus.converted,
            message: result.toString()));
      });
    } catch (ex) {
      emit(state.copyWith(
          translatorStatus: TranslatorStatus.failed, message: ex.toString()));
      print(ex.toString());
    }
  }

  void setInputValue(String value){
    emit(state.copyWith(message: value,translatorStatus: TranslatorStatus.listenText));
  }
}
