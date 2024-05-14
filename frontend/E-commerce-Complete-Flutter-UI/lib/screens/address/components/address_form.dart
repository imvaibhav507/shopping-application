import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/Address.dart';
import 'package:shop_app/screens/address/controller/address_controller.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {

  var controller = Get.find<AddressController>();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? house;
  String? street;
  String? lanmark;
  String? pincode;
  String? phone;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('New Address',
                  style: Theme.of(context).textTheme
                      .titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              onSaved: (newValue) => name = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kNamelNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kNamelNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter your full name",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User Icon.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              onSaved: (newValue) => house = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kAddressNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kAddressNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "House/Block no.",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.streetAddress,
              onSaved: (newValue) => street = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kAddressNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kAddressNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Road/Street",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Home.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.name,
              onSaved: (newValue) => lanmark = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kNamelNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kNamelNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Landmark",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Home.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (newValue) => pincode = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kNamelNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kNamelNullError);
                  return "";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Pincode",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.phone,
              onSaved: (newValue) => phone = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kPhoneNumberNullError);
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kPhoneNumberNullError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Phone",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Container(
                    width: 20, height: 20,
                    child: Center(child: Text("+91", style:Theme.of(context).textTheme
                        .titleSmall?.copyWith(color: Colors.deepOrange, fontWeight: FontWeight.bold)))),
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
              ),
            ),
            const SizedBox(height: 20),
            FormError(errors: errors),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  addAddress();
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  void addAddress() async {
    Address newAddress = Address(
      addressId: uuid.v1(),
      name: name,
      phone: phone,
      house: house,
      road: street,
      landmark: lanmark,
      pincode: pincode);

    await controller.addAddress(newAddress);
    await controller.getAddresses();
    Get.back();
  }
}
