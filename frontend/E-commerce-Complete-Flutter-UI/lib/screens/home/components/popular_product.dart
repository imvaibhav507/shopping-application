import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/components/demo_product_card.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/controller/home_screen_controller.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';
import '../../../components/product_card.dart';
import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({super.key});

  var controller = Get.find<HomeScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Get.toNamed(AppRoutes.productsScreen, arguments: {'popular': controller.productItemListObj.value});
            },
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() {
            return Row(
              children: [
                ...List.generate(
                  controller.productItemListObj.value.productItemList?.length ?? 0,
                  (index) {
                    final item = controller.productItemListObj.value.productItemList![index];
                    if (true) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductCard(
                          product: item,
                          onPress: () => Get.toNamed(AppRoutes.detailsScreen, arguments: item)),
                      );
                    }
                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            );
          }),
        )
      ],
    );
  }
}
