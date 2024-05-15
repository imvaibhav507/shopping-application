class AppUrl {
  static const String hostUrl = 'https://shopping-application-uig0.onrender.com';
  // static const String hostUrl = 'http://192.168.1.7:8080';
  static const String baseUrl = '$hostUrl/api/v1';

  static const String signUpApi = '$baseUrl/auth/register';
  static const String signInApi = '$baseUrl/auth/authenticate';


  static const String getUserProfileApi = '$baseUrl/user';

  static const String getProductsByCategoryApi = "$baseUrl/product/";
  static const String getPopularProductsApi = "$baseUrl/product/popular";
  static const String getProductDetailsByIdApi = "$baseUrl/product/item/";
  static const String getAvailableSizesByItemIdApi = "$baseUrl/product/item/size";

  static const String getUserCartApi = "$baseUrl/user/cart";
  static const String addItemToCartApi = "$baseUrl/user/cart";

  static const String favouriteItemApi = "$baseUrl/product/item/favourite";

  static const String addressApi = "$baseUrl/user/address";

  static const String placeOrderApi = "$baseUrl/user/order";
}