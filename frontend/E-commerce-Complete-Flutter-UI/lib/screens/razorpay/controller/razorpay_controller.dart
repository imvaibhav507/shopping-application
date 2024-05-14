import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController extends GetxController {

  late Razorpay _razorpay;

  RxInt totalAmount = (0).obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    totalAmount.value = await Get.arguments;
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if(totalAmount.value!=0) {
      openCheckOut(totalAmount.value);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Order placed! ${response.paymentId}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed! ${response.message}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    Fluttertoast.showToast(
        msg: "External wallet ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckOut(int amount) async {
    amount = amount*100;
    var options = {
      'key': 'rzp_test_1DP5mm0lF5G5ag',
      'amount': amount,
      'name': 'Shopper',
      'description': 'Payment',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    }catch(e) {
      debugPrint("Error: $e");
    }
  }
}