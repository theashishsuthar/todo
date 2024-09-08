import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/util/language_util.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(languageCode: 'en')) {
    on<ChangeLanguage>((event, emit) async {
      await LanguageUtil.saveLanguage(event.languageCode);
      emit(state.copyWith(languageCode: event.languageCode));
    });

    on<GetSavedLanguage>((event, emit) async {
      final savedLanguage = await LanguageUtil.getInitialLanguage();
      emit(state.copyWith(languageCode: savedLanguage));
    });
  }
}