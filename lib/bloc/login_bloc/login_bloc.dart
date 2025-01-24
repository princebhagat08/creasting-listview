import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_services.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseServices firebaseServices = FirebaseServices();

  LoginBloc() : super(const LoginState()) {
    on<LoginWithPhone>(_loginWithPhone);
    on<LoginWithEmail>(_loginWithEmail);
    on<SendPhoneOTP>(_sentOTP);
    on<ValidateOTP>(_validateOtp);
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
    final bool isSent = await firebaseServices.sendOtp(number);
    if (isSent) {
      emit(state.copyWith(isOtpSent: isSent, loginStatus: LoginStatus.success));
    } else {
      emit(state.copyWith(
          isOtpSent: isSent,
          loginStatus: LoginStatus.error,
          errorMessage: 'OTP not sent'));
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
}
