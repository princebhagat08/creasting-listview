import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/app_url.dart';

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<ProductModel> getProduct() async {
    dynamic response = await _apiService.getApi(AppUrl.productApi);
    return ProductModel.fromJson(response);
  }
}
