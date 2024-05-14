import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/Address.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/order_confirmation/controller/confirmation_controller.dart';
import 'components/address_card.dart';
import 'components/payment_methods.dart';
import 'components/price_breakdown.dart';

class OrderConfirmationPage extends StatelessWidget {
  OrderConfirmationPage({super.key});

  OrderConfirmationController controller =
      Get.put(OrderConfirmationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Order Confirmation',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          centerTitle: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Obx(() {
              if (controller.isAddressLoading.isTrue) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final address = controller.defaultAddressModel.value.address;
              if(address?.addressId == null) {
                return Container();
              }
              return AddressCard(address: address);
            }),
            Obx(() => (controller.isPriceBreakdownLoading.isFalse)
                ? PriceBreakDown()
                : const CircularProgressIndicator()),
            PaymentMethods(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Obx(() {
            if(controller.defaultAddressModel.value.address?.addressId == null) {
              return ElevatedButton(
                  child: const Text('Add Address'),
                  onPressed: () async {
                    onTapAddAddress();
                  });
            }
            else if(controller.selectedPaymentMode?.value == "online") {
              return ElevatedButton(
                  child: Text('Pay Now (₹${controller.setFinalPrice()})'),
                  onPressed: () async {
                    await controller.placeOrders();
                  });
            }
            return ElevatedButton(
                child: Text('Pay Cash (₹${controller.setFinalPrice()})'),
                onPressed: () async {
                  await controller.placeOrders();
                });
          }),
        ),
      ),
    );
  }

  void onTapAddAddress() {
    Get.toNamed(AppRoutes.selectAddressScreen, arguments: Address().addressId)
        ?.then((result) async {
      String? selectedAddressId = await result.value;
      if (!(selectedAddressId == null || selectedAddressId == '')) {
        controller.getDeliveryAddressById(selectedAddressId);
      }
    });
  }
}

//   else {
//
//     Get.toNamed(AppRoutes.razorPayScreen, arguments: controller.setFinalPrice());
//   }
