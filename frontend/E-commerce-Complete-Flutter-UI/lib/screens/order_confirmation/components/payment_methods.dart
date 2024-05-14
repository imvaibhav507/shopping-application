import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/order_confirmation/controller/confirmation_controller.dart';

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  var controller = Get.find<OrderConfirmationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.grey.shade50,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Mode',
                  style: Theme.of(context).textTheme
                      .titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
              Obx(
                  ()=> RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
                    title: const Text('Razorpay'),
                    value: 'online',
                    groupValue: controller.selectedPaymentMode?.value,
                    onChanged: (value) {
                      controller.selectedPaymentMode?.value = value!;
                      print(controller.selectedPaymentMode?.value);
                    }
                ),
              ),

              Obx(
                  ()=> RadioListTile(
                    activeColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
                    title: const Text('Cash On Delivery'),
                    value: 'cash',
                    groupValue: controller.selectedPaymentMode?.value,
                    onChanged: (value) {
                      controller.selectedPaymentMode?.value = value!;
                      print(controller.selectedPaymentMode?.value);
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
