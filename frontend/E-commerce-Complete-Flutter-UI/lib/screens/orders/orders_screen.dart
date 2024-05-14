import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/orders/components/order_line_card.dart';
import 'package:shop_app/screens/orders/controller/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  OrdersController controller = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Your Orders', style: Theme.of(context).textTheme.titleMedium,),
          ),
          body: Obx(
              ()=>(controller.isLoading.isFalse)? ListView.builder(
              itemCount: controller.orderLinesModelObj.value.orderLines?.length ?? 0,
                itemBuilder: (context, index) {
                var orderLine = controller.orderLinesModelObj.value.orderLines![index];
                  return OrderLineCard(orderLine: orderLine);
                },
            ): const Center(child: CircularProgressIndicator(),),
          ),
        )
    );
  }
}
