import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_color_map.dart';
import 'package:shop_app/core/utils/pref_utils.dart';
import 'package:shop_app/screens/details/controller/product_details_controller.dart';
import 'package:shop_app/screens/details/models/product_item_detail_model.dart';
import '../../../constants.dart';

class ColorDots extends StatelessWidget {
  ColorDots({
    Key? key,
    required this.colors,
  }) : super(key: key);

  final List<AvailableColor> colors;
  var controller = Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    controller.selectedColor = colors.indexWhere((availableColor) => availableColor.color == controller.itemModel.color).obs;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          ...List.generate(
            colors.length,
            (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => ColorDot(
                    color: getColorFromName(colors[index].color!),
                    isSelected: index == controller.selectedColor.value,
                    onTap: () {
                      controller.selectedColor.value = index;
                      controller.itemModel.color = colors[index].color;
                      controller.itemModel.id = colors[index].id;
                      controller.itemModel.picture = controller.productItemDetailModelObj.value.itemDetails?.pictures?.first;
                      controller.getProductDetails(colors[index].id!, controller.itemModel.productId!);
                      controller.isItemInCart.value = false;
                    }
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: 70,
                  height: 20,
                  child: Center(
                    child: Text(
                      PrefUtils()
                          .processStringRegExp(colors[index].color!, '_', ' ')
                          .capitalizeFirst!,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  ColorDot({Key? key, required this.color, this.isSelected = false, this.onTap})
      : super(key: key);

  final Color color;
  final bool isSelected;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(2),
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(

              color: isSelected ? kPrimaryColor : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
