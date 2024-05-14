import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/order_confirmation/controller/confirmation_controller.dart';

class OrderSplashScreen extends StatelessWidget {
  OrderSplashScreen({super.key});
  var controller = Get.find<OrderConfirmationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Obx(
        () => (controller.placingOrder.isFalse)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(100)),
                    child: CustomImageView(
                      imagePath: "assets/icons/Success.svg",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Order Placed',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 190,
                    child: ElevatedButton(
                        child: Text('Back to Home'),
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.initScreen);
                        }),
                  )
                ],
              )
            : const SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                  strokeWidth: 3)),
      ),
    )));
  }
}
