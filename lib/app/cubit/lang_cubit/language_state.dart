enum LanguageStatus { initial, selected, notSelected }

class LanguageState {
  LanguageStatus languageStatus;
  String message;
  String selectedLanguageFrom;
  String selectedLanguageTo;

  LanguageState(
      {required this.languageStatus,
      required this.message,
      required this.selectedLanguageFrom,
      required this.selectedLanguageTo});

  factory LanguageState.initial() {
    return LanguageState(
        languageStatus: LanguageStatus.initial,
        message: '',
        selectedLanguageFrom: '',
        selectedLanguageTo: '');
  }

  LanguageState copyWith(
      {final LanguageStatus? languageStatus,
      String? message,
      String? selectedLanguageFrom,
      String? selectedLanguageTo}) {
    return LanguageState(
      languageStatus: languageStatus ?? this.languageStatus,
      message: message ?? this.message,
      selectedLanguageFrom: selectedLanguageFrom ?? this.selectedLanguageFrom,
      selectedLanguageTo: selectedLanguageTo ?? this.selectedLanguageTo,
    );
  }
}
