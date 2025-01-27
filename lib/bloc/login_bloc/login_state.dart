import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginState extends Equatable {
  final bool isLoginWithPhone;
  final bool isOtpSent;
  final LoadingStatus loginStatus;
  final bool isVerified;
  final String? errorMessage;
  final bool isHidePassword;
  final String mockNumber;
  final String mockOtp;
  final bool isLogout;

  const LoginState(
      {this.isLoginWithPhone = true,
      this.isOtpSent = false,
      this.loginStatus = LoadingStatus.initial,
      this.isVerified = false,
      this.errorMessage,
      this.isHidePassword = true,
      this.mockNumber = '+919876543210',
       this.mockOtp = '582852',
        this.isLogout = false,
      });

  LoginState copyWith(
      {bool? isLoginWithPhone,
      bool? isOtpSent,
      LoadingStatus? loginStatus,
      bool? isVerified,
      String? errorMessage,
      bool? isHidePassword,
      String? mockNumber,
        String? mockOtp,
        bool? isLogout
      }) {
    return LoginState(
        isLoginWithPhone: isLoginWithPhone ?? this.isLoginWithPhone,
        isOtpSent: isOtpSent ?? this.isOtpSent,
        loginStatus: loginStatus ?? this.loginStatus,
        isVerified: isVerified ?? this.isVerified,
        errorMessage: errorMessage ?? this.errorMessage,
        isHidePassword: isHidePassword ?? this.isHidePassword,
        mockNumber: mockNumber ?? this.mockNumber,
        mockOtp: mockOtp ?? this.mockOtp,
      isLogout: isLogout ?? this.isLogout,
    );
  }

  @override
  List<Object?> get props =>
      [isLoginWithPhone, isOtpSent, loginStatus, isVerified, errorMessage, isHidePassword, mockNumber, mockOtp,isLogout];
}
