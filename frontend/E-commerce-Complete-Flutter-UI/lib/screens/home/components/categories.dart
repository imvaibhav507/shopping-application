import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import 'package:shop_app/core/utils/image_constants.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/routes.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": ImageConstant.imgJacket, "text": "Jackets", "category": Category.JACKETS},
      {"icon": ImageConstant.imgShirt, "text": "Shirts", "category": Category.SHIRTS},
      {"icon": ImageConstant.imgTshirt, "text": "T-Shirts", "category": Category.T_SHIRTS},
      {"icon": ImageConstant.imgTrackpants, "text": "Track Pants", "category": Category.TRACK_PANTS},
      {"icon": ImageConstant.imgTrousers, "text": "Trousers", "category": Category.TROUSERS},
      {"icon": ImageConstant.imgJeans, "text": "Jeans", "category": Category.JEANS},
      {"icon": ImageConstant.imgTop, "text": "Tops", "category": Category.TOPS},
      {"icon": ImageConstant.imgKurta, "text": "Kurtas", "category": Category.KURTAS},
      {"icon": ImageConstant.imgPalazzo, "text": "Palazzos", "category": Category.PALAZZOS},
      {"icon": ImageConstant.imgSkirt, "text": "Skirts", "category": Category.SKIRTS},
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 90,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: () {
                onPressGoToProductItems(categories[index]["category"]);
              },
            );
          },
        ),
      ),
    );
  }

  void onPressGoToProductItems(Category category) {
    Get.toNamed(AppRoutes.productsScreen, arguments: {"category": category});
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            height: 65,
            width: 58,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomImageView(
              imagePath: icon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
