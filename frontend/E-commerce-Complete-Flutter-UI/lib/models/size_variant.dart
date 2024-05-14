class SizeVariant {
  String? size;
  int? quantity;

  SizeVariant({this.size, this.quantity});

  SizeVariant.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    return data;
  }
}