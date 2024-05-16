import 'package:get/get.dart';
import 'package:shop_app/data/response/api_response.dart';
import 'package:shop_app/repositories/cart_repository.dart';
import 'package:shop_app/repositories/products_repository.dart';
import 'package:shop_app/screens/details/models/product_item_detail_model.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';
import '../../../models/Cart.dart';

class ProductDetailsController extends GetxController {

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    itemModel = await Get.arguments;
    print(itemModel.toJson());
    getProductDetails(itemModel.id!, itemModel.productId!);
  }

  RxBool isLoading = false.obs;
  RxBool isCartButtonLoading = false.obs;
  RxBool isItemInCart = false.obs;
  RxBool isFav = false.obs;
  RxInt selectedSize = (-1).obs;
  RxInt selectedColor = (-1).obs;
  ProductsRepository productsRepository = ProductsRepository();
  CartRepository cartRepository = CartRepository();
  ProductItemModel itemModel = ProductItemModel();
  Rx<ProductItemDetailModel> productItemDetailModelObj = ProductItemDetailModel().obs;

  setLoading(value) {
    isLoading.value = value;
  }

  setCartButtonLoading(value) {
    isCartButtonLoading.value = value;
  }

  setIsFav(value) {
    isFav.value = value;
  }

  Future<void> getProductDetails(String itemId,String productId) async {
    setLoading(true);
    selectedSize.value = -1;
    await productsRepository.getProductDetailsById(itemId, productId).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        productItemDetailModelObj.value = ProductItemDetailModel.fromJson(data);
        setIsFav(productItemDetailModelObj.value.itemDetails!.favourite!);
        setLoading(false);
      }
    });
    setLoading(false);
  }

  Future<void> addItemToCart(CartItem cartItem) async {
    setCartButtonLoading(true);
    await cartRepository.addItemToCartApi(cartItem).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        print(data['data']);
        isItemInCart.value = true;
        setCartButtonLoading(false);
      }
    });
    setCartButtonLoading(false);
  }

  Future<void> modifyFavourite(String itemId) async {
    await productsRepository.modifyFavouriteItem(itemId).then((value) async{
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200){
        print(data['data']);
      }
    });
  }

}