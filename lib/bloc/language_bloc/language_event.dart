import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final String newLanguage;

  ChangeLanguage(this.newLanguage);

  @override
  List<Object> get props => [newLanguage];
}
