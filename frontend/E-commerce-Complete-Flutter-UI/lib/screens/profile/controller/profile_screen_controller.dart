import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/repositories/user_repository.dart';
import 'package:shop_app/routes.dart';

class ProfileController extends GetxController {
  ProfileController();

  UserRepository userRepository = UserRepository();
  late SharedPreferences sp;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    super.onInit();
    sp = await SharedPreferences.getInstance();
  }

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> logout() async {
    sp.remove('token')
        .then((value) => Get.offAllNamed(AppRoutes.splashScreen));
  }


}