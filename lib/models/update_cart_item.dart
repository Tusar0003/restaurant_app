class UpdateCartItem {
  String? cartId;
  String? mobileNumber;
  String? quantity;
  String? subTotalPrice;

  UpdateCartItem({this.cartId, this.mobileNumber, this.quantity, this.subTotalPrice});

  UpdateCartItem.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    mobileNumber = json['mobile_number'];
    quantity = json['quantity'];
    subTotalPrice = json['sub_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['mobile_number'] = this.mobileNumber;
    data['quantity'] = this.quantity;
    data['sub_total_price'] = this.subTotalPrice;
    return data;
  }
}
