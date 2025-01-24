import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginState extends Equatable {
  final bool isLoginWithPhone;
  final bool isOtpSent;
  final LoginStatus loginStatus;
  final bool isVerified;
  final String? errorMessage;

  const LoginState(
      {this.isLoginWithPhone = true,
      this.isOtpSent = false,
      this.loginStatus = LoginStatus.initial,
      this.isVerified = false,
      this.errorMessage = ''});

  LoginState copyWith(
      {bool? isLoginWithPhone,
      bool? isOtpSent,
      LoginStatus? loginStatus,
      bool? isVerified,
      String? errorMessage}) {
    return LoginState(
        isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
        isOtpSent: isOtpSent ?? this.isOtpSent,
        loginStatus: loginStatus ?? this.loginStatus,
        isVerified: isVerified ?? this.isVerified,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [isLoginWithPhone, isOtpSent, loginStatus, isVerified, errorMessage];
}
