import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/my_account/controller/my_account_controller.dart';
import 'package:shop_app/screens/my_account/models/user_profile_model.dart';
import 'package:shop_app/screens/profile/components/gender_button.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';

class MyAccountForm extends StatefulWidget {
  MyAccountForm(this.userProfile, {super.key});
  UserProfileModel userProfile;
  @override
  _MyAccountFormState createState() => _MyAccountFormState();
}

class _MyAccountFormState extends State<MyAccountForm> {

  UserProfileModel get user => widget.userProfile;
  var controller = Get.find<MyAccountController>();
  final _formKey = GlobalKey<FormState>();
  RxString? name = ''.obs;
  RxString? email = ''.obs;
  String? password;
  String? conform_password;
  RxString? selectedGender = ''.obs;
  bool remember = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGender?.value = user.gender!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TextFormField(
            initialValue: user.fullname,
            keyboardType: TextInputType.name,
            onSaved: (newValue) => name = RxString(newValue!),
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
              labelText: "Name",
              hintText: "Enter your name",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: user.email,
            readOnly: true,
            onSaved: (newValue) => email = RxString(newValue!),
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: 'ffffffff',
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          // TextFormField(
          //   obscureText: true,
          //   initialValue: 'ffffffff',
          //   onSaved: (newValue) => conform_password = newValue,
          //   onChanged: (value) {
          //     if (value.isNotEmpty) {
          //       removeError(error: kPassNullError);
          //     } else if (value.isNotEmpty && password == conform_password) {
          //       removeError(error: kMatchPassError);
          //     }
          //     conform_password = value;
          //   },
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       addError(error: kPassNullError);
          //       return "";
          //     } else if ((password != value)) {
          //       addError(error: kMatchPassError);
          //       return "";
          //     }
          //     return null;
          //   },
          //   decoration: const InputDecoration(
          //     labelText: "Confirm Password",
          //     hintText: "Re-enter your password",
          //     // If  you are using latest version of flutter then lable text and hint text shown like this
          //     // if you r using flutter less then 1.20.* then maybe this is not working properly
          //     floatingLabelBehavior: FloatingLabelBehavior.always,
          //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          //   ),
          // ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Select your gender:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GenderRadioButton(selectedGender),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                onPressUpdateProfile();
              }
            },
            child: const Text("Update Profile"),
          ),
        ],
      ),
    );
  }

  void onPressUpdateProfile() async {
    UserProfileModel updatedProfile = UserProfileModel(
      id: user.id,
      fullname: name?.value,
      email: email?.value,
      gender: selectedGender?.value
    );
    await controller.updateUserProfile(updatedProfile);
  }
}
