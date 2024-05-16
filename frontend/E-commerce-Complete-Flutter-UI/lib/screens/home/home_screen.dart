import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/home/controller/home_screen_controller.dart';

import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.getPopularProducts(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                HomeHeader(),
                DiscountBanner(),
                Categories(),
                SpecialOffers(),
                SizedBox(height: 20),
                PopularProducts(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
