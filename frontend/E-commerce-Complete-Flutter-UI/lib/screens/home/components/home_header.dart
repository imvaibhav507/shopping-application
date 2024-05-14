import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/routes.dart';

import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 6),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 3,
            press: () {},
          ),
          const SizedBox(width: 6),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Get.toNamed(AppRoutes.cartScreen),
          ),
          const SizedBox(width: 6),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Heart Icon.svg",
            press: () {
              Get.toNamed(AppRoutes.favouriteScreen);
            },
          ),
        ],
      ),
    );
  }
}
