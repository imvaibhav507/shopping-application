import 'package:get/get.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/favorite/available_sizes_model.dart';
import '../../../data/response/api_response.dart';
import '../../../repositories/cart_repository.dart';
import '../../../repositories/products_repository.dart';
import '../../products/models/product_item_model.dart';

class FavouritesController extends GetxController {

  final productsRepository = ProductsRepository();
  final cartRepository = CartRepository();
  Rx<ProductItemListModel> productItemListObj = ProductItemListModel().obs;
  Rx<AvailableSizesModel> sizeVariantsObj = AvailableSizesModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFavouriteItems();
  }
  RxBool isLoading = false.obs;
  RxBool isCartButtonLoading = false.obs;
  RxBool availableSizesLoading = false.obs;
  RxInt selectedSize = (-1).obs;

  setLoading(value) {
    isLoading.value = value;
  }

  setCartButtonLoading(value) {
    isCartButtonLoading.value = value;
  }

  setAvailableSizes(value) {
    availableSizesLoading.value = value;
  }

  Future<void> getFavouriteItems() async {
    setLoading(true);
    await productsRepository.getFavouriteItems().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        productItemListObj.value = ProductItemListModel.fromJson(data);
        setLoading(false);
      }
    });
    setLoading(false);
  }

  Future<void> getAvailableSizes(String itemId) async {
    setAvailableSizes(true);
    await productsRepository.getAvailableSizes(itemId).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        sizeVariantsObj.value = AvailableSizesModel.fromJson(data);
        setAvailableSizes(false);
      }
    });
    setAvailableSizes(false);
  }

  Future<void> moveItemToCart(CartItem cartItem) async {
    setCartButtonLoading(true);
    await cartRepository.addItemToCartApi(cartItem).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        print(data['data']);
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