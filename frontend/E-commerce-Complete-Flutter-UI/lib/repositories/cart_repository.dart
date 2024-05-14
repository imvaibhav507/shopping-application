import 'package:shop_app/apis/app_urls.dart';

import '../data/network/network_api_services.dart';

class CartRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> addItemToCartApi(var data) async {
    dynamic response = _apiService.postApi(AppUrl.addItemToCartApi, data);
    return response;
  }

  Future<dynamic> getUserCartApi() async {
    dynamic response = _apiService.getApi(AppUrl.getUserCartApi);
    return response;
  }

}