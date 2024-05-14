import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/details/controller/product_details_controller.dart';
import '../../../constants.dart';
import '../../../models/size_variant.dart';

class SizeDots extends StatelessWidget {
  SizeDots({super.key, required this.sizeVariants});

  var controller = Get.find<ProductDetailsController>();
  final List<SizeVariant> sizeVariants;

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
            sizeVariants.length,
            (index) => Obx(
              () => SizeDot(
                sizeVariant: sizeVariants[index],
                isSelected: index == controller.selectedSize.value,
                onTap: () {
                  controller.selectedSize.value = index;
                  controller.isItemInCart.value = false;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeDot extends StatelessWidget {
  SizeDot(
      {super.key,
      required this.sizeVariant,
      this.isSelected = false,
      this.onTap,
      this.height,
      this.width,
      this.style});

  final SizeVariant sizeVariant;
  bool isSelected;
  VoidCallback? onTap;
  double? height;
  double? width;
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(2),
      height: height ?? 36,
      width: width ?? 36,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.black38),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('${sizeVariant.size}', style: style ?? Theme.of(context).textTheme.labelLarge,),
            ),
          ),
          onTap: () {
            onTap?.call();
          }),
    );
  }
}
