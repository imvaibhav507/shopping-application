import '../apis/app_urls.dart';
import '../data/network/network_api_services.dart';

class OrderRepository {

  final _apiService = NetworkApiServices();

  Future<dynamic> placeOrder(var data) async {
    dynamic response = _apiService.postApi(AppUrl.placeOrderApi, data);
    return response;
  }
}