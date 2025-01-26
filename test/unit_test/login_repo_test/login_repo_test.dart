import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:youbloomdemo/repository/login_repo/login_repository.dart';
import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/model/login_model.dart';
import 'package:youbloomdemo/utils/app_url.dart';

// Generate mock class
@GenerateNiceMocks([MockSpec<NetworkApiServices>()])
import 'login_repo_test.mocks.dart';

void main() {
  late LoginRepository loginRepository;
  late MockNetworkApiServices mockNetworkApiServices;

  setUp(() {
    mockNetworkApiServices = MockNetworkApiServices();
    loginRepository = LoginRepository();
    loginRepository.apiService = mockNetworkApiServices;
  });

  group('LoginRepository Tests', () {
    test('loginApi should return LoginModel on successful API call', () async {
      // Arrange
      final loginData = {"email": "john@mail.com", "password": "changeme"};
      final mockResponse = {
        "access_token": "mock_access_token",
        "refresh_token": "mock_refresh_token"
      };

      // Setup mock behavior
      when(mockNetworkApiServices.postApi(loginData, AppUrl.loginApi))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await loginRepository.loginApi(loginData);

      // Assert
      expect(result, isA<LoginModel>());
      verify(mockNetworkApiServices.postApi(loginData, AppUrl.loginApi))
          .called(1);
    });

    test('loginApi should throw exception when API call fails', () async {
      // Arrange
      final loginData = {'email': 'test@test.com', 'password': '123456'};

      // Setup mock behavior to throw exception
      when(mockNetworkApiServices.postApi(loginData, AppUrl.loginApi))
          .thenThrow(Exception('API Error'));

      // Act & Assert
      expect(
        () => loginRepository.loginApi(loginData),
        throwsA(isA<Exception>()),
      );
      verify(mockNetworkApiServices.postApi(loginData, AppUrl.loginApi))
          .called(1);
    });
  });
}
