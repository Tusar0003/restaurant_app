class OrderHistory {
  List<OrderData>? pendingData;
  List<OrderData>? confirmedData;

  OrderHistory({this.pendingData, this.confirmedData});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    if (json['pending_data'] != null) {
      pendingData = <OrderData>[];
      json['pending_data'].forEach((v) {
        pendingData!.add(new OrderData.fromJson(v));
      });
    }
    if (json['confirmed_data'] != null) {
      confirmedData = <OrderData>[];
      json['confirmed_data'].forEach((v) {
        confirmedData!.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingData != null) {
      data['pending_data'] = this.pendingData!.map((v) => v.toJson()).toList();
    }
    if (this.confirmedData != null) {
      data['confirmed_data'] =
          this.confirmedData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
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
  int? isPrepared;
  int? isCompleted;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;
  List<Items>? items;

  OrderData({
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
    this.isPrepared,
    this.isCompleted,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime,
    this.items
  });

  OrderData.fromJson(Map<String, dynamic> json) {
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
    isPrepared = json['is_food_prepared'];
    isCompleted = json['is_completed'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    data['is_completed'] = this.isCompleted;
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

class Items {
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

  Items({this.id,
    this.orderNo,
    this.itemCode,
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.subTotalPrice,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime});

  Items.fromJson(Map<String, dynamic> json) {
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