import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/model/login_model.dart';
import 'package:youbloomdemo/repository/login_repo/login_repository.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_services.dart';
import 'package:youbloomdemo/services/session_manager/session_controller.dart';
import 'package:youbloomdemo/utils/enums.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseServices firebaseServices = FirebaseServices();
  final LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(const LoginState()) {
    on<LoginWithPhone>(_loginWithPhone);
    on<LoginWithEmail>(_loginWithEmail);
    on<SendPhoneOTP>(_sentOTP);
    on<ValidateOTP>(_validateOtp);
    on<ValidateUser>(_validateUser);
    on<HidePassword>(_showPassword);
    on<SendMockOtp>(_sendMockOtp);
    on<ValidateMockOtp>(_validateMockOtp);
    on<LogoutUser>(_logout);
  }

  // toggle to phone auth
  void _loginWithPhone(LoginWithPhone event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoginWithPhone: true));
  }

  // toggle to email and password login
  void _loginWithEmail(LoginWithEmail event, Emitter<LoginState> emit) {
    emit(state.copyWith(isLoginWithPhone: false));
  }

  // send otp using firebase
  void _sentOTP(SendPhoneOTP event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoadingStatus.loading));
    final number = event.phoneNumber;

    try {
      final isSent =
          await firebaseServices.sendOtp(number).whenComplete(() async {
        await Future.delayed(Duration(seconds: 5));
      });

      if (isSent != null && isSent) {
        emit(state.copyWith(
          isOtpSent: isSent,
          loginStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          loginStatus: LoadingStatus.error,
          errorMessage: 'invalid_credentials',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        loginStatus: LoadingStatus.error,
        errorMessage: 'invalid_credentials',
      ));
    }
  }

  // validate firebase otp
  void _validateOtp(ValidateOTP event, Emitter<LoginState> emit) async {
    final otp = event.otp;
    try {
      final bool isVerified = await firebaseServices.verifyOtp(otp);
      emit(state.copyWith(
          isVerified: isVerified,
          loginStatus:
              isVerified ? LoadingStatus.success : LoadingStatus.error));
    } catch (error) {
      emit(state.copyWith(
          loginStatus: LoadingStatus.error,
          errorMessage: 'invalid_otp'));
    }
  }

  // login user with email and password
  void _validateUser(ValidateUser event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoadingStatus.loading));

    try {
      Map data = {"email": event.email, "password": event.password};

      await loginRepository.loginApi(data).then((response) async {
        if (response != null && response.message == null ) {
          await SessionController().saveUserInPreference(response);
          await SessionController().getUserFromPreference();
          emit(state.copyWith(loginStatus: LoadingStatus.success));
        } else {
          emit(state.copyWith(
              loginStatus: LoadingStatus.error,
              errorMessage: response?.message ??
                  'invalid_credentials'));
        }
      });
    } catch (error) {
      emit(state.copyWith(
          loginStatus: LoadingStatus.error,
          errorMessage: 'invalid_credentials'));
    }
  }

  // show or hide password
  void _showPassword(HidePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(isHidePassword: !state.isHidePassword));
  }

  // send mock otp
  void _sendMockOtp(SendMockOtp event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoadingStatus.loading));
    await Future.delayed(Duration(seconds: 2), () {
      if (state.mockNumber == event.mockNumber) {
        emit(state.copyWith(
            loginStatus: LoadingStatus.success, errorMessage: ''));
      } else {
        emit(state.copyWith(
            loginStatus: LoadingStatus.error,
            errorMessage: 'invalid_phone_number'));
      }
    });
  }

  // validate mock otp
  void _validateMockOtp(ValidateMockOtp event, Emitter<LoginState> emit) async{
    final String mockToken = 'kjaljsdlfjljglajdlkgjlkajdfkajkg';
    if (state.mockOtp == event.otp) {
      emit(state.copyWith(isVerified: true));
      await SessionController().saveUserInPreference(LoginModel(accessToken: mockToken));
      await SessionController().getUserFromPreference();
    } else {
      emit(state.copyWith(isVerified: false, errorMessage: 'invalid_otp'));
    }
  }

//   logout user
  void _logout(LogoutUser event, Emitter<LoginState> emit)async{
    try{
      await SessionController().eraseUserData();
      emit(state.copyWith(isLogout:true));
    }catch (e){
      emit(state.copyWith(isLogout: false));
    }


  }


}
