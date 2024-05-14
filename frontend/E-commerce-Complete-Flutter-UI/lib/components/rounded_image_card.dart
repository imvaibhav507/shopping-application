import 'package:flutter/cupertino.dart';

import '../core/utils/custom_image_view.dart';

Widget RoundedImageCard(
    {String? imagePath, double? height, double? width, double? aspectRatio, double? radius}) {
  return SizedBox(
    height: height,
    width: width?? 60,
    child: AspectRatio(
      aspectRatio: aspectRatio ?? 0.80,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        child: CustomImageView(
          imagePath: imagePath,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
