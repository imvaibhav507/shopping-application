import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/order_confirmation/controller/confirmation_controller.dart';

class PriceBreakDown extends StatelessWidget {
  PriceBreakDown({super.key});

  var controller = Get.find<OrderConfirmationController>();
  int deliveryFee = 30;
  int discounts = 456;
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
              Text('Price Details',
                  style: Theme.of(context).textTheme
                      .titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('Bag Total',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  Obx(
                    ()=> SizedBox(
                      width: 100,
                      child: Text('₹${controller.itemTotal}',
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('Discounts',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text('-₹${controller.discounts}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.green)),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text('Delivery Fee',
                      style: Theme.of(context).textTheme.titleSmall,),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text('₹${controller.deliveryFee}',
                      style: Theme.of(context).textTheme.titleSmall,),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 100,
                      child: Text('Total Amount' ,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                  SizedBox(
                      width: 100,
                      child: Text('₹${controller.setFinalPrice()}' ,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold))
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
