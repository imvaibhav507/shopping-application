import '../../../models/Address.dart';

class DefaultAddressModel {
  int? status;
  Address? address;

  DefaultAddressModel({this.status, this.address});

  DefaultAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    address = json['data'] != null ? new Address.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.address != null) {
      data['data'] = this.address!.toJson();
    }
    return data;
  }
}