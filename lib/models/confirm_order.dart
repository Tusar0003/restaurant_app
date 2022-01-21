class ConfirmOrder {
  String? mobileNumber;
  String? orderType;
  String? deliveryCharge;

  ConfirmOrder({this.mobileNumber, this.orderType, this.deliveryCharge});

  ConfirmOrder.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    orderType = json['order_type'];
    deliveryCharge = json['delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = this.mobileNumber;
    data['order_type'] = this.orderType;
    data['delivery_charge'] = this.deliveryCharge;
    return data;
  }
}
