import 'package:get/get.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/repositories/order_repository.dart';

import '../../../data/response/api_response.dart';

class OrdersController extends GetxController {

  final orderRepository = OrderRepository();
  Rx<OrderLinesModel> orderLinesModelObj = OrderLinesModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllOrders();
  }

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> getAllOrders() async {
    setLoading(true);
    await orderRepository.getAllOrders().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        orderLinesModelObj.value = OrderLinesModel.fromJson(data);
        setLoading(false);
      }
    });
    setLoading(false);
  }
}