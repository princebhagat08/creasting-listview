import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  final bool isLoginWithPhone;
  // final String? phoneNumber;

  const LoginState({this.isLoginWithPhone = true, });

  LoginState copyWith({bool? isLoginWithPhone, }){
  return LoginState(isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
    // phoneNumber: phoneNumber ?? this.phoneNumber,
  );
  }

  @override
  List<Object?> get props => [isLoginWithPhone,];

}