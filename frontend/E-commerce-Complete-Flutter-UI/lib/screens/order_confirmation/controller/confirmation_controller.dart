import 'package:get/get.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/repositories/address_repository.dart';
import 'package:shop_app/repositories/order_repository.dart';
import 'package:shop_app/screens/order_confirmation/models/default_address_model.dart';

import '../../../data/response/api_response.dart';
import '../../../routes.dart';

class OrderConfirmationController extends GetxController {

  AddressRepository addressRepository = AddressRepository();
  OrderRepository orderRepository = OrderRepository();
  Rx<DefaultAddressModel> defaultAddressModel = DefaultAddressModel().obs;

  RxString? itemTotal = "".obs;
  RxList<Order>? orders = <Order>[].obs;
  RxBool placingOrder = false.obs;
  RxBool isAddressLoading = false.obs;
  RxBool isPriceBreakdownLoading = false.obs;
  RxInt deliveryFee = 30.obs;
  RxInt discounts = 456.obs;
  RxString? selectedPaymentMode = "online".obs;

  setAddressLoading(value) {
    isAddressLoading.value = value;
  }

  setPriceBreakdownLoading(value) {
    isPriceBreakdownLoading.value = value;
  }

  int setFinalPrice() {
    return int.parse(itemTotal!.value) + deliveryFee.value - discounts.value;
  }

  setPlacingOrder(value) {
    placingOrder.value = value;
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    setPriceBreakdownLoading(true);
    final args = await Get.arguments;
    itemTotal?.value = args['itemTotal'];
    orders?.value = args['orders'];
    if(!(itemTotal!.value.isEmpty || itemTotal?.value == '')) {
      setPriceBreakdownLoading(false);
    }
    getDeliveryAddress();
  }

  Future<void> getDeliveryAddress() async{
    setAddressLoading(true);
    await addressRepository.getSingleUserAddress().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        defaultAddressModel.value = DefaultAddressModel.fromJson(data);
        setAddressLoading(false);
      }
    });
    setAddressLoading(false);
  }

  Future<void> getDeliveryAddressById(String addressId) async{
    setAddressLoading(true);
    await addressRepository.getAddressById(addressId).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        defaultAddressModel.value = DefaultAddressModel.fromJson(data);
        setAddressLoading(false);
      }
    });
    setAddressLoading(false);
  }

  Future<void> placeOrders() async {
    setPlacingOrder(true);
    Get.toNamed(AppRoutes.orderSplashScreen);
    await orderRepository.placeOrder(orders?.toJson()).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        print(data);
        setPlacingOrder(false);
      }
    });
    setPlacingOrder(false);
  }
}