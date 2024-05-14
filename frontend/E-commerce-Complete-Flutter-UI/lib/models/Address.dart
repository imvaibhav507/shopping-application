import 'package:get/get.dart';

class UserAddressModel {
  int? status;
  RxList<Address>? addresses;

  UserAddressModel({this.status, this.addresses});

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      addresses = RxList(<Address>[]);
      json['data'].forEach((v) {
        addresses!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.addresses != null) {
      data['data'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? addressId;
  String? name;
  String? phone;
  String? house;
  String? road;
  String? landmark;
  String? pincode;

  Address(
      {this.addressId,
        this.name,
        this.phone,
        this.house,
        this.road,
        this.landmark,
        this.pincode});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    name = json['name'];
    phone = json['phone'];
    house = json['house'];
    road = json['road'];
    landmark = json['landmark'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this.addressId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['house'] = this.house;
    data['road'] = this.road;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    return data;
  }
}
