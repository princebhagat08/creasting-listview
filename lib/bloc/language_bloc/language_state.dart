import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final String languageCode;

  const LanguageState({this.languageCode = 'en'});

  LanguageState copyWith({required String languageCode}){
    return LanguageState(languageCode:languageCode?? this.languageCode);
  }

  @override
  List<Object> get props => [languageCode];
}
