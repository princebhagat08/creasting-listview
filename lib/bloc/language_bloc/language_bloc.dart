import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/config/internationalization/language.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final language = Language();
  LanguageBloc() : super(LanguageState()) {
    on<ChangeLanguage>(_changeLanguage);
  }

  void _changeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    language.switchLanguage(event.newLanguage);
    emit(state.copyWith(languageCode: event.newLanguage));
  }
}
