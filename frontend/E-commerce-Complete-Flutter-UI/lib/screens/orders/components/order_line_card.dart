import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/components/rounded_image_card.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/models/size_variant.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/details/components/size_dots.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';
import '../../../constants.dart';

class OrderLineCard extends StatelessWidget {
  OrderLineCard({
    Key? key,
    required this.orderLine,
  }) : super(key: key);

  final OrderLine orderLine;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey.shade100,
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tilePadding: const EdgeInsets.all(10),
      title: Row(
        children: [
          RoundedImageCard(imagePath: orderLine.orders?.first.picture),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order_Id: ${orderLine.id}'.toUpperCase(),
                style: const TextStyle(color: Colors.black, fontSize: 9),
                maxLines: 1,
              ),
              const Text(
                'Order Placed',
                style: TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Stack(children: [
                Text.rich(
                  TextSpan(
                    text: "Total MRP ${orderLine.totalPrice}",
                    style: const TextStyle(
                      fontSize: 14,
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 2.3,
                  child: SizedBox(
                    width: 90,
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                              "Qty ${getTotalItemsCount()}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ],
          ),
        ],
      ),
      children: List.generate(
          orderLine.orders?.length ?? 0,
              (index) {
            final order = orderLine.orders![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.grey.shade100,
                leading: RoundedImageCard(
                  imagePath: order.picture,
                  width: 40, aspectRatio: 0.75, radius: 10,),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${order.brand}'.toUpperCase(), style: Theme.of(context).textTheme.labelMedium,),
                    Text('${order.name}', style: Theme.of(context).textTheme.labelMedium,),
                    Text('MRP ${order.price}'.toUpperCase(), style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),)
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizeDot(sizeVariant: SizeVariant(size: order.size), width: 22,),
                    const SizedBox(width: 3,),
                    Text('Qty ${order.quantity}',
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  getTotalItemsCount() {
    int count = 0;
    orderLine.orders?.forEach((order) { count += order.quantity!;});
    return count;
  }
}
