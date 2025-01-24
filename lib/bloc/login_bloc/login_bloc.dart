import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  LoginBloc():super(const LoginState()){
    on<LoginWithPhone>(_loginWithPhone);
    on<LoginWithEmail>(_loginWithEmail);
    on<SendPhoneOTP>(_sentOTP);
  }

  void _loginWithPhone(LoginWithPhone event, Emitter<LoginState> emit){
    emit(state.copyWith(isLoginWithPhone: true));
  }

  void _loginWithEmail(LoginWithEmail event, Emitter<LoginState> emit){
    emit(state.copyWith(isLoginWithPhone: false));
  }

  void _sentOTP(SendPhoneOTP event, Emitter<LoginState> emit){
    final number = event.phoneNumber;
  }


  // void _phoneValidation(ValidatePhoneNumber event, Emitter<LoginState> emit){
  //   final number = event.phoneNumber;
  //   if (number.isEmpty) {
  //     emit(state.copyWith(errorMsgForPhoneValidation: 'Please enter phone number'));
  //     return;
  //   }
  //
  //   if (number.length < 8) {
  //     emit(state.copyWith(errorMsgForPhoneValidation: 'Please enter valid phone number'));
  //     return;
  //   }
  //
  //   emit(state.copyWith(errorMsgForPhoneValidation: null));
  // }
  }




