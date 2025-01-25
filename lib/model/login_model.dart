class LoginModel {
  String? _accessToken;
  String? _refreshToken;
  String? _message;

  LoginModel({String? accessToken, String? refreshToken, String? message}) {
    if (accessToken != null) {
      this._accessToken = accessToken;
    }
    if (refreshToken != null) {
      this._refreshToken = refreshToken;
    }
    if(message != null){
      this._message = message;
    }
  }

  String? get accessToken => _accessToken;
  set accessToken(String? accessToken) => _accessToken = accessToken;
  String? get refreshToken => _refreshToken;
  set refreshToken(String? refreshToken) => _refreshToken = refreshToken;
  String? get message => _message;
  set message(String? message) => _message = message;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
    _message = json['message'];
  }


}
