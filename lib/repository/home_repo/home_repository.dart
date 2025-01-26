import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/app_url.dart';

class HomeRepository {
  NetworkApiServices apiService = NetworkApiServices();

  Future<ProductModel> getProduct(int limit, int page) async {
    dynamic response = await apiService.getApi('${AppUrl.productApi}?limit=$limit&skip=${limit*(page-1)}');
    return ProductModel.fromJson(response);
  }
}
