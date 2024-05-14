import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/models/Address.dart';
import 'package:shop_app/screens/address/controller/address_controller.dart';

class SavedAddress extends StatelessWidget {
  SavedAddress({super.key, this.address});
  Address? address;

  var controller = Get.find<AddressController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Address',
                      style: Theme.of(context).textTheme
                          .titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Edit', style:Theme.of(context).textTheme
                      .titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepOrange))
                ],
              ),
              Text('${address?.name}',
                  style: Theme.of(context).textTheme
                      .titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              Text('${address?.house}, ${address?.road}',
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 4,
              ),
              Text('${address?.road}',
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 4,
              ),
              Row(
                children: [
                  Text('Pincode : ' ,style: Theme.of(context).textTheme.titleSmall),
                  Text('${address?.pincode}' ,style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              Row(
                children: [
                  Text('Phone : ' ,style: Theme.of(context).textTheme.titleSmall),
                  Text('+91-${address?.phone}' ,style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 90),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: GestureDetector(
                      onTap: () async {
                        await controller.removeAddress(address!.addressId!);
                        controller.userAddressModel.value.addresses?.remove(address);
                      },
                        child: SvgPicture.asset('assets/icons/Trash.svg')),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
