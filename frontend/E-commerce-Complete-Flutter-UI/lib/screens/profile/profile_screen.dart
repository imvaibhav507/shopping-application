import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/profile/controller/profile_screen_controller.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends GetWidget{

  ProfileScreen({super.key});

  @override
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Get.toNamed(AppRoutes.myAccountScreen)
              },
            ),
            ProfileMenu(
              text: "Saved Addresses",
              icon: "assets/icons/Parcel.svg",
              press: () => {
                Get.toNamed(AppRoutes.addressScreen)
              },
            ),
            ProfileMenu(
              text: "Your Orders",
              icon: "assets/icons/shop order.svg",
              press: () => {
                Get.toNamed(AppRoutes.ordersScreen)
              }
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }

}
