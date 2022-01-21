class AddToCart {
  String? mobileNumber;
  String? itemCode;
  String? itemName;
  String? quantity;
  String? unitPrice;
  String? subTotalPrice;

  AddToCart({
    this.mobileNumber,
    this.itemCode,
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.subTotalPrice
  });

  AddToCart.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    subTotalPrice = json['sub_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = this.mobileNumber;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['sub_total_price'] = this.subTotalPrice;
    return data;
  }
}
