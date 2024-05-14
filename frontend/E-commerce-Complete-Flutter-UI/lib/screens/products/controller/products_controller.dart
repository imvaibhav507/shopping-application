import 'package:get/get.dart';
import 'package:shop_app/data/response/api_response.dart';
import 'package:shop_app/repositories/products_repository.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';

import '../../../enums.dart';

class ProductsController extends GetxController {

  Rx<Category> category = (Category.NONE).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    final args = await Get.arguments;
    if(args['popular']==null) {
      category.value = args['category'];
      getProductsByCategory();
    }
    else {
      productItemListObj.value = args['popular'];
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    dispose();
  }

  final productsRepository = ProductsRepository();

  Rx<ProductItemListModel> productItemListObj = ProductItemListModel().obs;

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> getProductsByCategory() async {
    setLoading(true);
    await productsRepository.getProductsByCategory(category.value).then(
            (value) async {
              final response = await ApiResponse.completed(value);
              final data = response.data as Map<String, dynamic>;
              if(data['status'] == 200) {
                productItemListObj.value = ProductItemListModel.fromJson(data);
                setLoading(false);
              }
            }
    ).onError((error, stackTrace) {
      print(error.toString());
    });
    setLoading(false);
  }
}