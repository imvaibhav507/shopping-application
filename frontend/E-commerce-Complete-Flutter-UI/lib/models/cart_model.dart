class CartModel {
  int? status;
  List<CartItem>? cartItems;

  CartModel({this.status, this.cartItems});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      cartItems = <CartItem>[];
      json['data'].forEach((v) {
        cartItems!.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cartItems != null) {
      data['data'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  String? itemId;
  String? productItem;
  String? name;
  String? brand;
  String? picture;
  String? price;
  String? size;
  int? quantity;

  CartItem(
      {this.itemId,
        this.productItem,
        this.name,
        this.brand,
        this.picture,
        this.price,
        this.size,
        this.quantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    productItem = json['productItem'];
    name = json['name'];
    brand = json['brand'];
    picture = json['picture'];
    price = json['price'];
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['productItem'] = this.productItem;
    data['name'] = this.name;
    data['brand'] = this.brand;
    data['picture'] = this.picture;
    data['price'] = this.price;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    return data;
  }
}
