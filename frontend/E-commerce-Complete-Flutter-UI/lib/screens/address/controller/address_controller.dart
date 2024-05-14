import 'package:get/get.dart';
import 'package:shop_app/models/Address.dart';
import 'package:shop_app/repositories/address_repository.dart';
import '../../../data/response/api_response.dart';

class AddressController extends GetxController {

  AddressRepository addressRepository = AddressRepository();
  Rx<UserAddressModel> userAddressModel = UserAddressModel().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAddresses();
    selectedAddress?.value = await Get.arguments ?? '';
  }

  RxBool addAddressLoading = false.obs;
  RxBool getAddressesLoading = false.obs;
  RxBool removeAddressLoading = false.obs;
  RxString? selectedAddress = ''.obs;

  setGetAddresses(value) {
    getAddressesLoading.value = value;
  }

  setAddAddress(value) {
    addAddressLoading.value = value;
  }

  setRemoveAddress(value) {
    removeAddressLoading.value = value;
  }

  Future<void> addAddress(Address address) async {
    setAddAddress(true);
    await addressRepository.addNewAddress(address.toJson()).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        setAddAddress(false);
      }
    });
    setAddAddress(false);
  }

  Future<void> getAddresses() async {
    setGetAddresses(true);
    await addressRepository.getUserAddresses().then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        userAddressModel.value = UserAddressModel.fromJson(data);
        setGetAddresses(false);
      }
    });
    setGetAddresses(false);
  }

  Future<void> removeAddress(String id) async {
    setRemoveAddress(true);
    await addressRepository.removeUserAddress(id).then((value) async {
      final response = await ApiResponse.completed(value);
      final data = response.data as Map<String, dynamic>;
      if(data['status'] == 200) {
        userAddressModel.value.addresses?.removeWhere((address) => address.addressId == id);
        setRemoveAddress(false);
      }
    });
    setRemoveAddress(false);
  }
}