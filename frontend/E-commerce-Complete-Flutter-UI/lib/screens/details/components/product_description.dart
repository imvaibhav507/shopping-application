import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/details/controller/product_details_controller.dart';
import 'package:shop_app/screens/details/models/product_item_detail_model.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';

class ProductDescription extends StatelessWidget {
  ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ItemDetails product;
  final GestureTapCallback? pressOnSeeMore;
  var controller = Get.find<ProductDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${product.brand}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              GestureDetector(
                onTap: () {
                  onTapModifyItem(product.id!);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    ()=> Container(
                      padding: const EdgeInsets.all(8),
                      width: 35,
                      decoration: BoxDecoration(
                        color: (controller.isFav.isTrue)
                            ? const Color(0xFFFFE6E6)
                            : const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        colorFilter: ColorFilter.mode(
                            (controller.isFav.isTrue)
                                ? const Color(0xFFFF4848)
                                : const Color(0xFFDBDEE4),
                            BlendMode.srcIn),
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            "${product.name}",
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            "MRP ${product.price}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ),

        const SizedBox(height: 8,),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam a velit eu urna lobortis vestibulum. Suspendisse eu placerat nulla. Cras sed diam hendrerit, ornare risus ut, congue lectus. Sed bibendum ac nibh nec hendrerit. In quis risus nec est condimentum dapibus sed in nunc. Cras non eros urna. Etiam consectetur.",
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          child: GestureDetector(
            onTap: () {},
            child: const Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void onTapModifyItem(String itemId) {
    controller.modifyFavourite(itemId);
    controller.isFav.value = !controller.isFav.value;
  }
}
