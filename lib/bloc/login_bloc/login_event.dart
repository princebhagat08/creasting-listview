import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithPhone extends LoginEvent {}

class SendPhoneOTP extends LoginEvent {
  final String phoneNumber;
  const SendPhoneOTP(this.phoneNumber,);
  @override
  List<Object?> get props => [phoneNumber];
}

class ValidateOTP extends LoginEvent{
  final String otp;
  const ValidateOTP(this.otp);
  @override
  List<Object?> get props => [otp];
}

class LoginWithEmail extends LoginEvent {}

class ValidateUser extends LoginEvent {
  final String email;
  final String password;
  const ValidateUser(this.email,this.password);
  @override
  List<Object> get props => [email,password];
}

class HidePassword extends LoginEvent{}

class SendMockOtp extends LoginEvent{
  final String mockNumber;
  const SendMockOtp(this.mockNumber);
  @override
  List<Object> get props => [];
}

class ValidateMockOtp extends LoginEvent{
  final String otp;
  const ValidateMockOtp(this.otp);
  @override
  List<Object> get props => [];
}

class LogoutUser extends LoginEvent{}
