enum TranslatorStatus { initial, converting, converted, failed,listenText }

class TranslatorState {
  TranslatorStatus translatorStatus;
  String message;

  TranslatorState({required this.translatorStatus, required this.message});

  factory TranslatorState.initial() {
    return TranslatorState(
        translatorStatus: TranslatorStatus.initial, message: '');
  }

  TranslatorState copyWith(
      {final TranslatorStatus? translatorStatus, String? message}) {
    return TranslatorState(
        translatorStatus: translatorStatus ?? this.translatorStatus,
        message: message ?? this.message);
  }
}
