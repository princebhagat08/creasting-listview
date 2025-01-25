import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginState extends Equatable {
  final bool isLoginWithPhone;
  final bool isOtpSent;
  final LoadingStatus loginStatus;
  final bool isVerified;
  final String? errorMessage;
  final bool isHidePassword;

  const LoginState(
      {this.isLoginWithPhone = true,
      this.isOtpSent = false,
      this.loginStatus = LoadingStatus.initial,
      this.isVerified = false,
      this.errorMessage,
      this.isHidePassword = true,
      });

  LoginState copyWith(
      {bool? isLoginWithPhone,
      bool? isOtpSent,
      LoadingStatus? loginStatus,
      bool? isVerified,
      String? errorMessage,
      bool? isHidePassword,
      }) {
    return LoginState(
        isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
        isOtpSent: isOtpSent ?? this.isOtpSent,
        loginStatus: loginStatus ?? this.loginStatus,
        isVerified: isVerified ?? this.isVerified,
        errorMessage: errorMessage ?? this.errorMessage,
        isHidePassword: isHidePassword ?? this.isHidePassword
    );
  }

  @override
  List<Object?> get props =>
      [isLoginWithPhone, isOtpSent, loginStatus, isVerified, errorMessage, isHidePassword];
}
