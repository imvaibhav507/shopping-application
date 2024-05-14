import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/Address.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/order_confirmation/controller/confirmation_controller.dart';

class AddressCard extends StatelessWidget {
  AddressCard({super.key, this.address});

  Address? address;
  var controller = Get.find<OrderConfirmationController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
              color: Theme.of(context).cardColor,
              elevation: 0.5,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery Address',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                          GestureDetector(
                            onTap: () {
                              onTapChangeAddress();
                            },
                            child: Text('Change',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.deepOrange)),
                          )
                        ],
                      ),
                      Text('${address?.name}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(
                        '${address?.house}',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                      ),
                      Text(
                        '${address?.road}',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text('Pincode : ',
                              style: Theme.of(context).textTheme.titleSmall),
                          Text('${address?.pincode}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Phone : ',
                              style: Theme.of(context).textTheme.titleSmall),
                          Text('+91-${address?.phone}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )),
            )
    );
  }

  void onTapChangeAddress() {
    Get.toNamed(AppRoutes.selectAddressScreen, arguments: address?.addressId)
        ?.then((result) async {
      String? selectedAddressId = await result.value;
      if (!(selectedAddressId == null || selectedAddressId == '')) {
        controller.getDeliveryAddressById(selectedAddressId);
      }
    });
  }
}
