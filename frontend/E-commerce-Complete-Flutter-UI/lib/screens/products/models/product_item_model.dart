import 'package:get/get.dart';

class ProductItemListModel {
  int? status;
  RxList<ProductItemModel>? productItemList;

  ProductItemListModel({this.status, this.productItemList});

  ProductItemListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      productItemList = RxList(<ProductItemModel>[]);
      json['data'].forEach((v) {
        productItemList!.add(new ProductItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.productItemList != null) {
      data['data'] = this.productItemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItemModel {
  String? id;
  String? name;
  String? brand;
  String? price;
  String? productId;
  String? category;
  String? picture;
  String? color;

  ProductItemModel(
      {this.id,
        this.name,
        this.brand,
        this.price,
        this.productId,
        this.category,
        this.picture,
        this.color});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['sid'];
    name = json['name'];
    brand = json['brand'];
    price = json['price'];
    productId = json['productId'];
    category = json['category'];
    picture = json['picture'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.id;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['productId'] = this.productId;
    data['category'] = this.category;
    data['picture'] = this.picture;
    data['color'] = this.color;
    return data;
  }
}
