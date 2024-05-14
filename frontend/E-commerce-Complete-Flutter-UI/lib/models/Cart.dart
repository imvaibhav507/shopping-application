class CartItem {
  String? itemId;
  String? productItem;
  String? product;
  String? price;
  String? picture;
  int? quantity;
  String? size;

  CartItem(
      {this.itemId,
        this.productItem,
        this.product,
        this.price,
        this.picture,
        this.quantity,
        this.size});

  CartItem.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    productItem = json['productItem'];
    product = json['product'];
    price = json['price'];
    picture = json['picture'];
    quantity = json['quantity'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['productItem'] = this.productItem;
    data['product'] = this.product;
    data['price'] = this.price;
    data['picture'] = this.picture;
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    return data;
  }
}
