class CartItem {
  int? id;
  String? mobileNumber;
  String? itemCode;
  String? itemName;
  int? quantity;
  int? unitPrice;
  int? discountPrice;
  int? subTotalPrice;
  int? isPromoCodeApplied;
  String? promoCode;
  String? promoCodeAmount;
  String? imagePath;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  CartItem({
    this.id,
    this.mobileNumber,
    this.itemCode,
    this.itemName,
    this.quantity,
    this.unitPrice,
    this.discountPrice,
    this.subTotalPrice,
    this.isPromoCodeApplied,
    this.promoCode,
    this.promoCodeAmount,
    this.imagePath,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNumber = json['mobile_number'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    discountPrice = json['discount_price'];
    subTotalPrice = json['sub_total_price'];
    isPromoCodeApplied = json['is_promo_code_applied'];
    promoCode = json['promo_code'];
    promoCodeAmount = json['promo_code_amount'].toString();
    imagePath = json['image_path'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_number'] = this.mobileNumber;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['sub_total_price'] = this.subTotalPrice;
    data['is_promo_code_applied'] = this.isPromoCodeApplied;
    data['promo_code'] = this.promoCode;
    data['image_path'] = this.imagePath;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
