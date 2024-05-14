import 'package:get/get.dart';

class OrderLineModel {
  int? status;
  RxList<Order>? orders;

  OrderLineModel({this.status, this.orders});

  OrderLineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      orders = RxList(<Order>[]);
      json['data'].forEach((v) {
        orders!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orders != null) {
      data['data'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? orderId;
  String? date;
  String? productItem;
  int? quantity;
  int? totalPrice;

  Order(
      {this.orderId,
        this.date,
        this.productItem,
        this.quantity,
        this.totalPrice});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    date = json['date'];
    productItem = json['productItem'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['date'] = this.date;
    data['productItem'] = this.productItem;
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    return data;
  }
}
