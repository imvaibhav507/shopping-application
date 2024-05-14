import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/details/controller/product_details_controller.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';
import '../../models/Cart.dart';
import '../../models/size_variant.dart';
import 'components/color_dots.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/size_dots.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  DetailsScreen({super.key});

  ProductDetailsController controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() => (controller.isLoading.isTrue)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ProductImages(
                    images: controller.productItemDetailModelObj.value
                        .itemDetails!.pictures!),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ProductDescription(
                        product: controller
                            .productItemDetailModelObj.value.itemDetails!,
                        pressOnSeeMore: () {},
                      ),
                      TopRoundedContainer(
                        color: const Color(0xFFF6F7F9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 8),
                              child: Text(
                                "Select Color",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            ColorDots(
                                colors: controller.productItemDetailModelObj
                                    .value.itemDetails!.availableColors!),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 20),
                              child: Text(
                                "Select Size",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            SizeDots(
                                sizeVariants: controller
                                    .productItemDetailModelObj
                                    .value
                                    .itemDetails!
                                    .sizeVariants!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Obx(
              () => ElevatedButton(
                onPressed: () {
                  if (controller.isItemInCart.isTrue) {
                    return;
                  } else if (controller.selectedSize.value == -1) {
                    print("Please select size");
                    return;
                  }
                  final sizes = controller.productItemDetailModelObj.value
                      .itemDetails!.sizeVariants!;
                  onPressAddToCart(sizes[controller.selectedSize.value]);
                },
                style: (controller.isItemInCart.isTrue)
                    ? ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey.shade100),
                        side: MaterialStateBorderSide.resolveWith((states) =>
                            const BorderSide(color: kPrimaryColor, width: 2)))
                    : null,
                child: Obx(() => (controller.isCartButtonLoading.isFalse)
                    ? Text(
                        (controller.isItemInCart.isFalse)
                            ? "Add To Cart"
                            : "Item added",
                        style: (controller.isItemInCart.isTrue)
                            ? Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: kPrimaryColor)
                            : null,
                      )
                    : const CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressAddToCart(SizeVariant size) async {
    final cartItem = CartItem(
        itemId: uuid.v1(),
        productItem: controller.itemModel.id,
        product: controller.itemModel.productId,
        price: controller.itemModel.price,
        picture: controller.productItemDetailModelObj.value
            .itemDetails!.pictures!.first,
        quantity: 1,
        size: size.size);
    await controller.addItemToCart(cartItem);
  }
}

class ProductDetailsArguments {
  final ProductItemModel product;

  ProductDetailsArguments({required this.product});
}
