import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/response/api_response.dart';
import 'package:shop_app/repositories/user_repository.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/sign_in/models/sign_in_model.dart';
import 'package:shop_app/screens/sign_in/models/token_model.dart';

class SignInController extends GetxController {

  Rx<SignInModel> signInModelObj = SignInModel().obs;

  UserRepository userRepository = UserRepository();

  RxBool isLoading = false.obs;

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> signIn(SignInModel model) async {
      setLoading(true);
      await userRepository.signInApi(model.toJson())
          .then((value) async {
        final response = await ApiResponse.completed(value);
        final data = response.data as Map<String, dynamic>;
        final token = TokenModel.fromJson(data).token;
        final sp = await SharedPreferences.getInstance();
        if(token != null) {
          sp.setString('token', token);
          Get.offNamed(AppRoutes.loginSuccessScreen);
        }
        setLoading(false);
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString());
        }
        setLoading(false);
      });
  }
}