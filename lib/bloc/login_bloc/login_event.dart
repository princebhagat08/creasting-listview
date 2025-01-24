import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithPhone extends LoginEvent {}

class LoginWithEmail extends LoginEvent {}

class SendPhoneOTP extends LoginEvent {
  final String phoneNumber;
  const SendPhoneOTP(this.phoneNumber,);
  @override
  List<Object?> get props => [phoneNumber];
}

class ValidateOTP extends LoginEvent{
  final String verificationId;
  final String otp;
  const ValidateOTP(this.verificationId,this.otp);
  @override
  List<Object?> get props => [verificationId,otp];
}

class ValidateEmail extends LoginEvent {}
