import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/core/utils/pref_utils.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/products/controller/products_controller.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  ProductsController controller = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text((controller.category.value == Category.NONE)
            ? ''
            : PrefUtils()
                .processStringRegExp(controller.category.value.name, '_', ' ')
                .capitalizeFirst!)),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getProductsByCategory(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              if (controller.productItemListObj.value.productItemList == null ||
                  controller.productItemListObj.value.productItemList!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                itemCount:
                    controller.productItemListObj.value.productItemList?.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.58,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => ProductCard(
                    product: controller
                        .productItemListObj.value.productItemList![index],
                    onPress: () {
                      final item = controller
                          .productItemListObj.value.productItemList![index];
                      print(item.toJson());
                      Get.toNamed(AppRoutes.detailsScreen, arguments: item);
                    }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
