import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/razorpay/controller/razorpay_controller.dart';

class RazorPayScreen extends StatelessWidget {
  RazorPayScreen({super.key});

  RazorpayController controller = Get.put(RazorpayController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

