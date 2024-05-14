import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/size_variant.dart';
import 'package:shop_app/screens/details/components/size_dots.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 82,
          child: AspectRatio(
            aspectRatio: 0.80,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CustomImageView(
                imagePath: cartItem.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${cartItem.brand}'.toUpperCase(),
              style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            Text(
              '${cartItem.name}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Stack(children: [
              Text.rich(
                TextSpan(
                  text: "MRP ${cartItem.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                widthFactor: 2.3,
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      const Spacer(),
                      RoundedIconBtn(
                        icon: Icons.remove,
                        showShadow: true,
                        press: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                            "${cartItem.quantity}",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                      RoundedIconBtn(
                        icon: Icons.add,
                        showShadow: true,
                        press: () {},
                      ),
                    ],
                  ),
                ),
              )
            ]),
            SizeDot(
                height: 23,
                width: 23,
                style: Theme.of(context).textTheme.labelSmall,
                sizeVariant: SizeVariant(size: "${cartItem.size}")
            )
          ],
        ),
      ],
    );
  }
}
