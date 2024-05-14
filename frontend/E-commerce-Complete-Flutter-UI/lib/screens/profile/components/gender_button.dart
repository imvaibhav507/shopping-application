import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderRadioButton extends StatelessWidget {

  GenderRadioButton(this.selectedGender,{super.key});

  RxString? selectedGender = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 155,
            child: RadioListTile(
              activeColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
              title: const Text('Male'),
              value: 'M',
              groupValue: selectedGender?.value,
              onChanged: (value) {
                selectedGender?.value = value as String;
              },
            ),
          ),
          SizedBox(
            width: 155,
            child: RadioListTile(
              activeColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
              title: const Text('Female'),
              value: 'F',
              groupValue: selectedGender?.value,
              onChanged: (value) {
                selectedGender?.value = value as String;
              },
            ),
          ),
        ],
      ),
    );
  }
}
