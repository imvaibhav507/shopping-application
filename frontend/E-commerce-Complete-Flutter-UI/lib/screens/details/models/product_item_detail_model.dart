import '../../../models/size_variant.dart';

class ProductItemDetailModel {
  int? status;
  ItemDetails? itemDetails;

  ProductItemDetailModel({this.status, this.itemDetails});

  ProductItemDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    itemDetails = json['data'] != null ? new ItemDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.itemDetails != null) {
      data['data'] = this.itemDetails!.toJson();
    }
    return data;
  }
}

class ItemDetails {
  String? id;
  String? name;
  String? brand;
  String? price;
  String? productId;
  String? category;
  List<String>? pictures;
  String? color;
  List<SizeVariant>? sizeVariants;
  List<AvailableColor>? availableColors;
  bool? favourite;

  ItemDetails(
      {this.id,
        this.name,
        this.brand,
        this.price,
        this.productId,
        this.category,
        this.pictures,
        this.color,
        this.sizeVariants,
        this.availableColors,
        this.favourite});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    price = json['price'];
    productId = json['productId'];
    category = json['category'];
    pictures = json['pictures'].cast<String>();
    color = json['color'];
    if (json['sizeVariants'] != null) {
      sizeVariants = <SizeVariant>[];
      json['sizeVariants'].forEach((v) {
        sizeVariants!.add(new SizeVariant.fromJson(v));
      });
    }
    if (json['availableColors'] != null) {
      availableColors = <AvailableColor>[];
      json['availableColors'].forEach((v) {
        availableColors!.add(new AvailableColor.fromJson(v));
      });
    }
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['category'] = this.category;
    data['pictures'] = this.pictures;
    data['color'] = this.color;
    if (this.sizeVariants != null) {
      data['sizeVariants'] = this.sizeVariants!.map((v) => v.toJson()).toList();
    }
    if (this.availableColors != null) {
      data['availableColors'] =
          this.availableColors!.map((v) => v.toJson()).toList();
    }
    data['favourite'] = this.favourite;
    return data;
  }
}

class AvailableColor {
  String? id;
  String? color;

  AvailableColor({this.id, this.color});

  AvailableColor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    return data;
  }
}
