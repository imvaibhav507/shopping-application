import 'package:get/get.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/repositories/cart_repository.dart';
import '../../../data/response/api_response.dart';

class CartController extends GetxController {

  Rx<CartModel> cartModelObj = CartModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserCart();
  }

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
  }

  CartRepository cartRepository = CartRepository();

  Future<void> getUserCart() async {
    setLoading(true);
    await cartRepository.getUserCartApi().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        cartModelObj.value = CartModel.fromJson(data);
        setLoading(false);
      }
    });
    setLoading(false);
  }
}