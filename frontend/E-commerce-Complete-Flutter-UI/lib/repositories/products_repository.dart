import 'package:shop_app/apis/app_urls.dart';
import 'package:shop_app/data/network/network_api_services.dart';

import '../enums.dart';

class ProductsRepository {
  
  final _apiService = NetworkApiServices();
  
  Future<dynamic> getProductsByCategory(Category category) async {
    dynamic response = _apiService.getApi("${AppUrl.getProductsByCategoryApi}?category=${category.name}");
    return response;
  }

  Future<dynamic> getPopularProducts() async {
    dynamic response = _apiService.getApi(AppUrl.getPopularProductsApi);
    return response;
  }

  Future<dynamic> getProductDetailsById(String itemId, String productId) async {
    dynamic response = _apiService.getApi("${AppUrl.getProductDetailsByIdApi}?itemId=$itemId&productId=$productId");
    return response;
  }

  Future<dynamic> getAvailableSizes(String itemId) async {
    dynamic response = _apiService.getApi("${AppUrl.getAvailableSizesByItemIdApi}?itemId=$itemId");
    return response;
  }

  Future<dynamic> modifyFavouriteItem(String itemId) async {
    dynamic response = _apiService.putApi("${AppUrl.favouriteItemApi}?itemId=$itemId", {});
    return response;
  }

  Future<dynamic> getFavouriteItems() async {
    dynamic response = _apiService.getApi(AppUrl.favouriteItemApi);
    return response;
  }
}