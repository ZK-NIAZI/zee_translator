import 'package:bloc/bloc.dart';
import 'package:zee_translator/app/cubit/lang_cubit/language_state.dart';


class LanguageCubit extends Cubit<LanguageState> {

  LanguageCubit() : super(LanguageState.initial());
  Future<void> setLangFrom(String lang) async{
    try{
      emit(state.copyWith(selectedLanguageFrom: lang));
    }
    catch(ex){
      emit(state.copyWith(message: ex.toString()));
    }
  }
  Future<void> setLangTo(String lang) async{
    try{
      emit(state.copyWith(selectedLanguageTo: lang));
    }
    catch(ex){
      emit(state.copyWith(message: ex.toString()));
    }
  }
}
