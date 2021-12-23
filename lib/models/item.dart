class Item {
  String? itemCode;
  String? itemName;
  String? description;
  int? quantity;
  int? price;
  String? vat;
  String? serviceCharge;
  int? isAllIncluded;
  int? isRecommended;
  double? averageRating;
  int? discountPercent;
  int? discountAmount;
  String? imagePath;
  int? isActive;
  String? categoryCode;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  Item({this.itemCode,
        this.itemName,
        this.description,
        this.quantity,
        this.price,
        this.vat,
        this.serviceCharge,
        this.isAllIncluded,
        this.isRecommended,
        this.averageRating,
        this.discountPercent,
        this.discountAmount,
        this.imagePath,
        this.isActive,
        this.categoryCode,
        this.createdBy,
        this.createdTime,
        this.updatedBy,
        this.updatedTime});

  Item.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    vat = json['vat'];
    serviceCharge = json['service_charge'];
    isAllIncluded = json['is_all_included'];
    isRecommended = json['is_recommended'];
    averageRating = json['average_rating'];
    discountPercent = json['discount_percent'];
    discountAmount = json['discount_amount'];
    imagePath = json['image_path'];
    isActive = json['is_active'];
    categoryCode = json['category_code'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['vat'] = this.vat;
    data['service_charge'] = this.serviceCharge;
    data['is_all_included'] = this.isAllIncluded;
    data['is_recommended'] = this.isRecommended;
    data['average_rating'] = this.averageRating;
    data['discount_percent'] = this.discountPercent;
    data['discount_amount'] = this.discountAmount;
    data['image_path'] = this.imagePath;
    data['is_active'] = this.isActive;
    data['category_code'] = this.categoryCode;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
