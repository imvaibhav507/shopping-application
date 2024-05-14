import 'package:get/get.dart';

class OrderLinesModel {
  int? status;
  RxList<OrderLine>? orderLines;

  OrderLinesModel({this.status, this.orderLines});

  OrderLinesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      orderLines = RxList(<OrderLine>[]);
      json['data'].forEach((v) {
        orderLines!.add(new OrderLine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orderLines != null) {
      data['data'] = this.orderLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLine {
  String? id;
  String? user;
  int? totalPrice;
  List<Order>? orders;
  String? date;

  OrderLine({this.id, this.user, this.totalPrice, this.orders, this.date});

  OrderLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    totalPrice = json['totalPrice'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(new Order.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['totalPrice'] = this.totalPrice;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class Order {
  String? orderId;
  String? productItem;
  String? brand;
  String? name;
  String? size;
  int? quantity;
  int? price;
  String? picture;

  Order(
      {this.orderId,
        this.productItem,
        this.brand,
        this.name,
        this.size,
        this.quantity,
        this.price,
        this.picture});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    productItem = json['productItem'];
    brand = json['brand'];
    name = json['name'];
    size = json['size'];
    quantity = json['quantity'];
    price = json['price'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['productItem'] = this.productItem;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['picture'] = this.picture;
    return data;
  }
}

