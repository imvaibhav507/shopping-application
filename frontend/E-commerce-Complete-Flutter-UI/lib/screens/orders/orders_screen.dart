import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
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
              () {
                if(controller.isLoading.isTrue) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(controller.orderLinesModelObj.value.orderLines!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                            child: CustomImageView(imagePath: "assets/icons/no order.svg",)),
                        Text('No Active Orders', style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(color: Colors.grey.shade600),)
                      ],
                    ));
                }
                return ListView.builder(
                  itemCount: controller.orderLinesModelObj.value.orderLines?.length ?? 0,
                  itemBuilder: (context, index) {
                    var orderLine = controller.orderLinesModelObj.value.orderLines![index];
                    return OrderLineCard(orderLine: orderLine);
                  },
                );
              },
          ),
        )
    );
  }
}
