import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_state.dart';
import 'package:youbloomdemo/model/login_model.dart';
import 'package:youbloomdemo/repository/login_repo/login_repository.dart';
import 'package:youbloomdemo/services/firebase_services/firebase_services.dart';
import 'package:youbloomdemo/utils/enums.dart';

// Create mocks
class MockFirebaseServices extends Mock implements FirebaseServices {}

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
  late LoginBloc loginBloc;
  late MockFirebaseServices mockFirebaseServices;
  late MockLoginRepository mockLoginRepository;

  setUp(() async {
    await Firebase.initializeApp();
    mockFirebaseServices = MockFirebaseServices();
    mockLoginRepository = MockLoginRepository();
    loginBloc = LoginBloc();
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginBloc', () {
    test('initial state is correct', () {
      expect(loginBloc.state, const LoginState());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [isLoginWithPhone: true] when LoginWithPhone is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginWithPhone()),
      expect: () => [
        const LoginState(isLoginWithPhone: true),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [isLoginWithPhone: false] when LoginWithEmail is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginWithEmail()),
      expect: () => [
        const LoginState(isLoginWithPhone: false),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'toggles password visibility when HidePassword is added',
      build: () => loginBloc,
      act: (bloc) => bloc.add(HidePassword()),
      expect: () => [
        const LoginState(isHidePassword: false),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits correct states for successful mock OTP sending',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const SendMockOtp('9876543210')),
      wait: const Duration(seconds: 3),
      expect: () => [
        const LoginState(loginStatus: LoadingStatus.loading),
        const LoginState(
            loginStatus: LoadingStatus.error,
            errorMessage: 'Invalid phone number'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits correct states for successful mock OTP validation',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const ValidateMockOtp('528852')),
      expect: () => [
        const LoginState(isVerified: false, errorMessage: 'Incorrect OTP'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits correct states for user validation with invalid credentials',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        ValidateUser('john@mail.com', 'changeme'),
      ),
      expect: () => [
        const LoginState(loginStatus: LoadingStatus.loading),
        const LoginState(
          loginStatus: LoadingStatus.error,
          errorMessage: 'Invalid credentials. Please try again.',
        ),
      ],
    );
  });
}
