import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/address/components/address_button.dart';
import 'components/address_form.dart';
import 'controller/address_controller.dart';

class SelectAddressScreen extends StatelessWidget {
  SelectAddressScreen({super.key});

  AddressController controller = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back(result: controller.selectedAddress);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text('Saved Addresses'),
      ),
      body: Obx(() {
        if (controller.getAddressesLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.userAddressModel.value.addresses!.isEmpty) {
          return const Center(
            child: Text("No addresses saved"),
          );
        }
        return ListView.builder(
            itemCount: controller.userAddressModel.value.addresses?.length ?? 0,
            itemBuilder: (context, index) {
              var address = controller.userAddressModel.value.addresses![index];
              return Stack(children: [
                AddressButton(address: address),
                Positioned(
                    left: -3,
                    top: 6,
                    child: Obx(
                      () => Radio(
                        value: address.addressId,
                        groupValue: controller.selectedAddress?.value,
                        onChanged: (value) {
                          controller.selectedAddress?.value = value!;
                        },
                      ),
                    )),
              ]);
            });
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 18),
        child: ElevatedButton(
          child: Text('Add new address'),
          onPressed: () {
            onPressOpenAddressForm();
          },
        ),
      ),
    ));
  }

  void onPressOpenAddressForm() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: true,
        context: Get.context!,
        builder: (context) {
          return AddressForm();
        });
  }
}
