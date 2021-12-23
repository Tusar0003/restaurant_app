class OrderType {
  int? id;
  String? orderType;
  int? deliveryCharge;
  int? isActive;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  OrderType({
    this.id,
    this.orderType,
    this.deliveryCharge,
    this.isActive,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime
  });

  OrderType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['order_type'];
    deliveryCharge = json['delivery_charge'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_type'] = this.orderType;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
