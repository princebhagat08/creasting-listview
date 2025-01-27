import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/language_bloc/language_bloc.dart';

class Language extends ChangeNotifier {
  static const String english = 'en';
  static const String hindi = 'hi';

  String _currentLanguage = english;

  String get languageCode => _currentLanguage;

  void switchLanguage(String newLanguage) {
    if (newLanguage != _currentLanguage) {
      _currentLanguage = newLanguage;
      notifyListeners();
    }
  }

  static String getCurrentLanguage(BuildContext context) {
    return context.read<LanguageBloc>().state.languageCode;
  }

  bool get isEnglish => _currentLanguage == english;
  bool get isHindi => _currentLanguage == hindi;

  static final Map<String, String> supportedLanguages = {
    english: 'English',
    hindi: 'हिंदी',
  };

  static final Map<String, Map<String, String>> translations = {
    english: {
      'demo_splash': 'Demo Splash',
      'welcome_back': 'Welcome Back',
      'phone': 'Phone',
      'email': 'Email',
      'phone_number': 'Phone Number',
      'password': 'Password',
      'login': 'Login',
      'enter_valid_phone': 'Enter valid phone number',
      'enter_verification_code': 'Enter Verification Code',
      'verification_code_sent':
          'We have sent a verification code to your mobile number',
      'verify': 'Verify',
      'didnt_receive_code': 'Didn\'t receive the code?',
      'resend': 'Resend',
      'invalid_phone_number': 'Invalid phone number',
      'enter_valid_phone_number': 'Enter valid phone number',
      'please_enter_email': 'Please enter email',
      'please_enter_password': 'Please enter password',
      'please_enter_valid_email': 'Please enter valid email',
      'error': 'Error',
      'Otp_length_error': 'OTP length is 6 digits',
      'invalid_otp': 'Invalid OTP',
      'enter_otp': 'Enter OTP',
      'something_went_wrong': 'Something went wrong',
      'invalid_credentials': 'Invalid credentials. Please try again',
      'login_successful': 'Login Successful',
      'search_products': 'Search products',
      'items': 'Items',
      'add_to_cart': 'Add to cart',
      'total_price': 'Total Price',
      'description': 'Description',
      'no_products_found': 'No products found',
      'product_added_to_cart': 'Product added to cart',
      'no_more_products': 'No more products',
    },
    hindi: {
      'demo_splash': 'डेमो स्प्लैश',
      'welcome_back': 'वापसी पर स्वागत है',
      'phone': 'फ़ोन',
      'email': 'ईमेल',
      'phone_number': 'फ़ोन नंबर',
      'password': 'पासवर्ड',
      'login': 'लॉग इन करें',
      'enter_valid_phone': 'मान्य फ़ोन नंबर दर्ज करें',
      'enter_verification_code': 'सत्यापन कोड दर्ज करें',
      'verification_code_sent':
          'हमने आपके मोबाइल नंबर पर एक सत्यापन कोड भेजा है',
      'verify': 'सत्यापित करें',
      'didnt_receive_code': 'कोड नहीं मिला?',
      'resend': 'पुनः भेजें',
      'invalid_phone_number': 'अमान्य फ़ोन नंबर',
      'enter_valid_phone_number': 'मान्य फ़ोन नंबर दर्ज करें',
      'please_enter_email': 'कृपया ईमेल दर्ज करें',
      'please_enter_password': 'कृपया पासवर्ड दर्ज करें',
      'please_enter_valid_email': 'कृपया मान्य ईमेल दर्ज करें',
      'error': 'त्रुटि',
      'invalid_credentials': 'अमान्य क्रेडेंशियल्स। कृपया पुनः प्रयास करें',
      'Otp_length_error': 'OTP लंबाई 6 अंक है',
      'invalid_otp': 'अमान्य OTP',
      'enter_otp': 'OTP दर्ज करें',
      'something_went_wrong': 'कुछ गलत हो गया',
      'login_successful': 'लॉगिन सफल',
      'search_products': 'उत्पाद खोजें',
      'items': 'वस्तुएं',
      'add_to_cart': 'कार्ट में जोड़ें',
      'total_price': 'कुल कीमत',
      'description': 'विवरण',
      'product_added_to_cart': 'उत्पाद कार्ट में जोड़ा गया',
      'no_products_found': 'उत्पाद नहीं मिले',
      'no_more_products': 'और कोई उत्पाद नहीं',
    },
  };

  String getText(String key) {
    return translations[_currentLanguage]?[key] ?? key;
  }
}
