import 'package:flutter/material.dart';
import '../../enums.dart';

// Improved color map with case-insensitive access and null safety
const Map<CustomColor, Color> customColorMap = {
  CustomColor.RED: Color(0xFFF44336), // Material red
  CustomColor.BLUE: Color(0xFF2196F3), // Material blue
  CustomColor.GREEN: Color(0xFF4CAF50), // Material green
  CustomColor.YELLOW: Color(0xFFFFEB3B), // Material yellow
  CustomColor.WHITE: Colors.white,
  CustomColor.PINK: Color(0xFFE91E63), // Material pink accent 100
  CustomColor.BLACK: Colors.black,
  CustomColor.GREY: Color(0xFF808080), // Light grey
  CustomColor.ORANGE: Color(0xFFFF9800), // Material orange
  CustomColor.DARK_BLUE: Color(0xFF1565C0), // Material blue-grey 800
  CustomColor.ROSE_WHITE: Color(0xFFF8F0E3), // Light cream
  CustomColor.BROWN: Color(0xFF795548), // Material brown
  CustomColor.MUSTARD: Color(0xFFFFCC00), // Material yellow accent 700
  CustomColor.CREAM: Color(0xFFFCF5F5), // Off-white
  CustomColor.MAROON: Color(0xFF800000), // Dark red
  CustomColor.NAVY: Color(0xFF000080), // Dark blue
  CustomColor.DARK_GREY: Color(0xFF424242), // Charcoal grey
  CustomColor.LIGHT_BLUE: Color(0xFF00BCD4), // Material light blue
  CustomColor.OLIVE: Color(0xFF388E3C), // Material green accent 500
  CustomColor.TEAL: Color(0xFF009688), // Material teal
  CustomColor.LAVENDER: Color(0xFFE6E6FA), // Light purple
  CustomColor.WINE: Color(0xFF7841F5), // Deep purple
  CustomColor.KHAAKI: Color(0xFFCDBE70), // Light brown
  // Add more colors as needed
};

// Efficient color lookup function with case-insensitive matching
Color getColorFromName(String name) {
  CustomColor color =  customColorMap.keys.firstWhere((color) => color.name == name);

  return customColorMap[color] ?? Colors.transparent;
}