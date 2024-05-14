import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/my_account/controller/my_account_controller.dart';
import '../profile/components/profile_pic.dart';
import 'components/my_account_form.dart';

class MyAccountScreen extends GetWidget {
  MyAccountScreen({super.key});
  @override
  MyAccountController controller = Get.put(MyAccountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Obx(
                () => (controller.isLoading.isTrue)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          const ProfilePic(),
                          const SizedBox(height: 16),
                          MyAccountForm(controller.userProfileModelObj.value),
                        ],
                      ),
              ),
            ),
          ),
        ));
  }
}
