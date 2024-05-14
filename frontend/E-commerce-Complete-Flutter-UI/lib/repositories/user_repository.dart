import 'package:shop_app/apis/app_urls.dart';
import 'package:shop_app/data/network/network_api_services.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> signUpApi(var data) async {
    dynamic response = _apiService.authApi(AppUrl.signUpApi, data);
    return response;
  }

  Future<dynamic> signInApi(var data) async {
    dynamic response = _apiService.authApi(AppUrl.signInApi, data);
    print(AppUrl.signInApi);
    return response;
  }

  Future<dynamic> getUserProfileApi() async {
    dynamic response = _apiService.getApi(AppUrl.getUserProfileApi);
    return response;
  }

  Future<dynamic> updateUserProfileApi(var data) async {
    dynamic response = _apiService.putApi(AppUrl.getUserProfileApi, data);
    return response;
  }
}