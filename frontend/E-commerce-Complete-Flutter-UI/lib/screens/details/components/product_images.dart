import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/custom_image_view.dart';
import '../../../constants.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 360,
            height: 445,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CustomImageView(
                imagePath: widget.images[selectedImage],
                fit: BoxFit.cover,
                radius: BorderRadius.circular(16),
              ),
            ),
          ),
          // SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  widget.images.length,
                  (index) => SmallProductImage(
                    isSelected: index == selectedImage,
                    press: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    image: widget.images[index],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
      required this.isSelected,
      required this.press,
      required this.image});

  final bool isSelected;
  final VoidCallback press;
  final String image;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        height: 48,
        width: 48,
        // padding: EdgeInsets.all(1),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(widget.isSelected ? 1 : 0)),
        ),
        child: CustomImageView(
          imagePath: widget.image,
          fit: BoxFit.cover,
          radius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
