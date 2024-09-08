part of 'language_bloc.dart';

class LanguageState {
  final String languageCode;

  const LanguageState({required this.languageCode});

  LanguageState copyWith({String? languageCode}) {
    return LanguageState(
      languageCode: languageCode ?? this.languageCode,
    );
  }
}