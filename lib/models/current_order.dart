class CurrentOrder {
  String? orderNo;
  String? mobileNumber;
  int? totalQuantity;
  int? totalPrice;
  int? isPromoCodeApplied;
  String? promoCode;
  String? totalDiscountAmount;
  String? orderType;
  int? deliveryCharge;
  int? isAccepted;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  List<CurrentOrderItems>? items;

  CurrentOrder({
    this.orderNo,
    this.mobileNumber,
    this.totalQuantity,
    this.totalPrice,
    this.isPromoCodeApplied,
    this.promoCode,
    this.totalDiscountAmount,
    this.orderType,
    this.deliveryCharge,
    this.isAccepted,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime,
    this.items
  });

  CurrentOrder.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    mobileNumber = json['mobile_number'];
    totalQuantity = json['total_quantity'];
    totalPrice = json['total_price'];
    isPromoCodeApplied = json['is_promo_code_applied'];
    promoCode = json['promo_code'];
    totalDiscountAmount = json['total_discount_amount'];
    orderType = json['order_type'];
    deliveryCharge = json['delivery_charge'];
    isAccepted = json['is_accepted'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];

    if (json['items'] != null) {
      items = <CurrentOrderItems>[];
      json['items'].forEach((v) {
        items!.add(new CurrentOrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_no'] = this.orderNo;
    data['mobile_number'] = this.mobileNumber;
    data['total_quantity'] = this.totalQuantity;
    data['total_price'] = this.totalPrice;
    data['is_promo_code_applied'] = this.isPromoCodeApplied;
    data['promo_code'] = this.promoCode;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['order_type'] = this.orderType;
    data['delivery_charge'] = this.deliveryCharge;
    data['is_accepted'] = this.isAccepted;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentOrderItems {
  int? id;
  String? orderNo;
  String? itemCode;
  String? itemName;
  int? quantity;
  int? unitPrice;
  int? subTotalPrice;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  CurrentOrderItems({
    this.id,
    this.orderNo,
    this.itemCode,
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.subTotalPrice,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime
  });

  CurrentOrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    subTotalPrice = json['sub_total_price'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['sub_total_price'] = this.subTotalPrice;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
