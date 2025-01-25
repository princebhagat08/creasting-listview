import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/repository/login_repo/login_repository.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_services.dart';
import 'package:youbloomdemo/services/session_manager/session_controller.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseServices firebaseServices = FirebaseServices();
  LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(const LoginState()) {
    on<LoginWithPhone>(_loginWithPhone);
    on<LoginWithEmail>(_loginWithEmail);
    on<SendPhoneOTP>(_sentOTP);
    on<ValidateOTP>(_validateOtp);
    on<ValidateUser>(_validateUser);
    on<HidePassword>(_showPassword);
  }

  void _loginWithPhone(LoginWithPhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoginWithPhone: true));
  }

  void _loginWithEmail(LoginWithEmail event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoginWithPhone: false));
  }

  void _sentOTP(SendPhoneOTP event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    final number = event.phoneNumber;

    try {
      final isSent = await firebaseServices.sendOtp(number).whenComplete(() async {
        await Future.delayed(Duration(seconds: 5));
      });

      if (isSent != null && isSent) {
        emit(state.copyWith(
          isOtpSent: isSent,
          loginStatus: LoginStatus.success,
        ));
      }else{
        emit(state.copyWith(
          loginStatus: LoginStatus.error,
          errorMessage:'OTP not sent',
        ));
      }
    } catch (error) {

      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        errorMessage: error.toString(),
      ));
    }
  }

  void _validateOtp(ValidateOTP event, Emitter<LoginState> emit) async {
    final verificationId = event.verificationId;
    final otp = event.otp;
    final bool isVerified =
        await firebaseServices.verifyOtp(verificationId, otp);
    emit(state.copyWith(
        isVerified: isVerified,
        loginStatus: isVerified ? LoginStatus.success : LoginStatus.error));
  }

  void _validateUser(ValidateUser event, Emitter<LoginState> emit) async {

    emit(state.copyWith(loginStatus: LoginStatus.loading));

    Map data ={
      "email": event.email,
      "password":event.password
    };


    await loginRepository.loginApi(data).then((response) async {
      if(response.message == null || response.message!.isEmpty){
        await SessionController().saveUserInPreference(response);
        await SessionController().getUserFromPreference();
        emit(state.copyWith(loginStatus: LoginStatus.success));
      }else{
        emit(state.copyWith(loginStatus: LoginStatus.error, errorMessage: '${response.message}\nPlease check your credentials'));
      }
    }).onError((error,stackTree){
      emit(state.copyWith(errorMessage: error.toString(),loginStatus: LoginStatus.error));
    });

  }

  void _showPassword(HidePassword evet, Emitter<LoginState> emit){
    emit(state.copyWith(isHidePassword : !state.isHidePassword));
  }


}
