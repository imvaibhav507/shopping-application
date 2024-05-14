import '../../models/size_variant.dart';

class AvailableSizesModel {
  int? status;
  List<SizeVariant>? sizeVariants;

  AvailableSizesModel({this.status, this.sizeVariants});

  AvailableSizesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sizeVariants = <SizeVariant>[];
      json['data'].forEach((v) {
        sizeVariants!.add(new SizeVariant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.sizeVariants != null) {
      data['data'] = this.sizeVariants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
