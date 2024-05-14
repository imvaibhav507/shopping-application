import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/details/components/size_dots.dart';
import 'package:shop_app/screens/favorite/controller/favourites_controller.dart';
import 'package:shop_app/screens/products/models/product_item_model.dart';
import '../../../constants.dart';
import '../../../models/size_variant.dart';

class FavouriteItemCard extends StatelessWidget {
  FavouriteItemCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 0.82,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductItemModel product;
  final VoidCallback onPress;

  var controller = Get.find<FavouritesController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: aspectRetio,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomImageView(
                  imagePath: product.picture,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${product.brand}".toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Text(
              "${product.name}",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Text(
              "\₹${product.price}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 110,
                  height: 22,
                  child: ElevatedButton(
                    onPressed: () {
                      onPressedSelectSize();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.zero),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade50),
                      side: MaterialStateBorderSide.resolveWith((states) =>
                          const BorderSide(color: kSecondaryColor, width: 1.2)),
                    ),
                    child: Text(
                      "Move To Cart",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: kSecondaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    onTapRemoveFavourite();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: false
                          ? kPrimaryColor.withOpacity(0.15)
                          : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Trash.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onPressedSelectSize() async {
    await controller.getAvailableSizes(product.id!);
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      "Select Size",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Obx(
                    ()=>(controller.availableSizesLoading.isFalse)? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                            controller.sizeVariantsObj.value.sizeVariants?.length ??
                                0, (index) {
                          final size =
                              controller.sizeVariantsObj.value.sizeVariants![index];
                          return SizeDot(
                              sizeVariant: SizeVariant(
                                  size: size.size, quantity: size.quantity),
                            isSelected: index == controller.selectedSize.value,
                            onTap: () {
                              controller.selectedSize.value = index;
                            },
                          );
                        })
                      ],
                    ): const Center(child: CircularProgressIndicator(),),
                  ),
                  const SizedBox(height: 24,),
                  ElevatedButton(
                      child: const Text("Move To Cart"),
                      onPressed: () {
                        if(controller.selectedSize.value == -1) {
                          print("please select size");
                          return;
                        }
                        final sizes = controller.sizeVariantsObj.value.sizeVariants;
                        onPressMoveToCart(sizes![controller.selectedSize.value]);
                      },
                  )
                ],
              ),
            ),
          );
        });
  }

  void onTapRemoveFavourite() async {
    await controller.modifyFavourite(product.id!);
    controller.productItemListObj.value.productItemList?.remove(product);
  }

  void onPressMoveToCart(SizeVariant size) async {

    final cartItem = CartItem(
        itemId: uuid.v1(),
        productItem: product.productId,
        price: product.price,
        picture: product.picture,
        quantity: 1,
        size: size.size);
    onTapRemoveFavourite();
    await controller.moveItemToCart(cartItem);
    Get.back();
  }
}
