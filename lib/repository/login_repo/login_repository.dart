import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/model/login_model.dart';
import 'package:youbloomdemo/utils/app_url.dart';

class LoginRepository {

   NetworkApiServices apiService  = NetworkApiServices() ;


  Future<LoginModel> loginApi(var data) async{
    dynamic response = await apiService.postApi(data, AppUrl.loginApi);
    return LoginModel.fromJson(response) ;
  }



}