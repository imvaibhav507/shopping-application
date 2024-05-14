import '../apis/app_urls.dart';
import '../data/network/network_api_services.dart';

class AddressRepository {

  final _apiService = NetworkApiServices();

  Future<dynamic> addNewAddress(var data) async {
    dynamic response = _apiService.postApi(AppUrl.addressApi, data);
    return response;
  }

  Future<dynamic> getUserAddresses() async {
    dynamic response = _apiService.getApi(AppUrl.addressApi);
    return response;
  }

  Future<dynamic> getSingleUserAddress() async {
    dynamic response = _apiService.getApi('${AppUrl.addressApi}/default');
    return response;
  }

  Future<dynamic> getAddressById(String id) async {
    dynamic response = _apiService.getApi('${AppUrl.addressApi}/?id=$id');
    return response;
  }

  Future<dynamic> removeUserAddress(String id) async {
    dynamic response = _apiService.deleteApi("${AppUrl.addressApi}?id=$id", {});
    return response;
  }
}