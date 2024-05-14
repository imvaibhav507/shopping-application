import 'package:get/get.dart';
import 'package:shop_app/data/response/api_response.dart';
import 'package:shop_app/repositories/products_repository.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';

class HomeScreenController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPopularProducts();
  }
  ProductsRepository productsRepository = ProductsRepository();

  Rx<ProductItemListModel> productItemListObj = ProductItemListModel().obs;

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> getPopularProducts() async {
    await productsRepository.getPopularProducts().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        productItemListObj.value = ProductItemListModel.fromJson(data);
        setLoading(false);
      }
    });
  }
}