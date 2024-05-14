import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/data/response/api_response.dart';
import 'package:shop_app/repositories/user_repository.dart';
import 'package:shop_app/screens/my_account/models/user_profile_model.dart';

class MyAccountController extends GetxController {

  Rx<UserProfileModel> userProfileModelObj = UserProfileModel().obs;
  UserRepository userRepository = UserRepository();
  late SharedPreferences sp;
  RxBool isLoading = false.obs;

  @override
  onInit() async {
    super.onInit();
    getUserProfile();
  }

  setLoading(value) {
    isLoading.value = value;
  }

  Future<void> getUserProfile() async {
    setLoading(true);
    await userRepository.getUserProfileApi().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      print(response);
      userProfileModelObj.value = UserProfileModel.fromJson(data);
      setLoading(false);
    }).onError((error, stackTrace) {
      print(error);
      setLoading(false);
    });
  }

  Future<void> updateUserProfile(UserProfileModel model) async {
    await userRepository.updateUserProfileApi(model.toJson()).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      print(response);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

}