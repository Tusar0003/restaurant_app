class HomeItem {
  List<CategoryList>? categoryList;
  List<CategoryWiseItemList>? categoryWiseItemList;
  List<RecommendedItemList>? recommendedItemList;

  HomeItem({this.categoryList, this.categoryWiseItemList, this.recommendedItemList});

  HomeItem.fromJson(Map<String, dynamic> json) {
    if (json['category_list'] != null) {
      categoryList = <CategoryList>[];
      json['category_list'].forEach((v) {
        categoryList!.add(new CategoryList.fromJson(v));
      });
    }
    if (json['category_wise_item_list'] != null) {
      categoryWiseItemList = <CategoryWiseItemList>[];
      json['category_wise_item_list'].forEach((v) {
        categoryWiseItemList!.add(new CategoryWiseItemList.fromJson(v));
      });
    }
    if (json['recommended_item_list'] != null) {
      recommendedItemList = <RecommendedItemList>[];
      json['recommended_item_list'].forEach((v) {
        recommendedItemList!.add(new RecommendedItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['category_list'] =
          this.categoryList!.map((v) => v.toJson()).toList();
    }
    if (this.categoryWiseItemList != null) {
      data['category_wise_item_list'] =
          this.categoryWiseItemList!.map((v) => v.toJson()).toList();
    }
    if (this.recommendedItemList != null) {
      data['recommended_item_list'] =
          this.recommendedItemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryList {
  String? createdTime;
  String? updatedBy;
  String? createdBy;
  String? updatedTime;
  bool? isActive;
  int? totalItemNo;
  String? categoryName;
  String? imagePath;
  String? categoryCode;

  CategoryList(
      {this.createdTime,
        this.updatedBy,
        this.createdBy,
        this.updatedTime,
        this.isActive,
        this.totalItemNo,
        this.categoryName,
        this.imagePath,
        this.categoryCode});

  CategoryList.fromJson(Map<String, dynamic> json) {
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    createdBy = json['created_by'];
    updatedTime = json['updated_time'];
    isActive = json['is_active'];
    totalItemNo = json['total_item_no'];
    categoryName = json['category_name'];
    imagePath = json['image_path'];
    categoryCode = json['category_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['created_by'] = this.createdBy;
    data['updated_time'] = this.updatedTime;
    data['is_active'] = this.isActive;
    data['total_item_no'] = this.totalItemNo;
    data['category_name'] = this.categoryName;
    data['image_path'] = this.imagePath;
    data['category_code'] = this.categoryCode;
    return data;
  }
}

class CategoryWiseItemList {
  String? createdBy;
  String? itemCode;
  String? createdTime;
  String? updatedTime;
  int? discountPercent;
  int? vat;
  bool? isRecommended;
  String? categoryCode;
  String? description;
  int? quantity;
  int? discountAmount;
  double? averageRating;
  int? price;
  String? updatedBy;
  int? serviceCharge;
  bool? isActive;
  String? itemName;
  bool? isAllIncluded;
  String? imagePath;

  CategoryWiseItemList(
      {this.createdBy,
        this.itemCode,
        this.createdTime,
        this.updatedTime,
        this.discountPercent,
        this.vat,
        this.isRecommended,
        this.categoryCode,
        this.description,
        this.quantity,
        this.discountAmount,
        this.averageRating,
        this.price,
        this.updatedBy,
        this.serviceCharge,
        this.isActive,
        this.itemName,
        this.isAllIncluded,
        this.imagePath});

  CategoryWiseItemList.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    itemCode = json['item_code'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    discountPercent = json['discount_percent'];
    vat = json['vat'];
    isRecommended = json['is_recommended'];
    categoryCode = json['category_code'];
    description = json['description'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    averageRating = json['average_rating'];
    price = json['price'];
    updatedBy = json['updated_by'];
    serviceCharge = json['service_charge'];
    isActive = json['is_active'];
    itemName = json['item_name'];
    isAllIncluded = json['is_all_included'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    data['item_code'] = this.itemCode;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['discount_percent'] = this.discountPercent;
    data['vat'] = this.vat;
    data['is_recommended'] = this.isRecommended;
    data['category_code'] = this.categoryCode;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['discount_amount'] = this.discountAmount;
    data['average_rating'] = this.averageRating;
    data['price'] = this.price;
    data['updated_by'] = this.updatedBy;
    data['service_charge'] = this.serviceCharge;
    data['is_active'] = this.isActive;
    data['item_name'] = this.itemName;
    data['is_all_included'] = this.isAllIncluded;
    data['image_path'] = this.imagePath;
    return data;
  }
}

class RecommendedItemList {
  String? createdBy;
  String? itemCode;
  String? createdTime;
  String? updatedTime;
  int? discountPercent;
  int? vat;
  bool? isRecommended;
  String? categoryCode;
  String? description;
  int? quantity;
  int? discountAmount;
  double? averageRating;
  int? price;
  String? updatedBy;
  int? serviceCharge;
  bool? isActive;
  String? itemName;
  bool? isAllIncluded;
  String? imagePath;

  RecommendedItemList({this.createdBy,
    this.itemCode,
    this.createdTime,
    this.updatedTime,
    this.discountPercent,
    this.vat,
    this.isRecommended,
    this.categoryCode,
    this.description,
    this.quantity,
    this.discountAmount,
    this.averageRating,
    this.price,
    this.updatedBy,
    this.serviceCharge,
    this.isActive,
    this.itemName,
    this.isAllIncluded,
    this.imagePath});

  RecommendedItemList.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    itemCode = json['item_code'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    discountPercent = json['discount_percent'];
    vat = json['vat'];
    isRecommended = json['is_recommended'];
    categoryCode = json['category_code'];
    description = json['description'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    averageRating = json['average_rating'];
    price = json['price'];
    updatedBy = json['updated_by'];
    serviceCharge = json['service_charge'];
    isActive = json['is_active'];
    itemName = json['item_name'];
    isAllIncluded = json['is_all_included'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_by'] = this.createdBy;
    data['item_code'] = this.itemCode;
    data['created_time'] = this.createdTime;
    data['updated_time'] = this.updatedTime;
    data['discount_percent'] = this.discountPercent;
    data['vat'] = this.vat;
    data['is_recommended'] = this.isRecommended;
    data['category_code'] = this.categoryCode;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['discount_amount'] = this.discountAmount;
    data['average_rating'] = this.averageRating;
    data['price'] = this.price;
    data['updated_by'] = this.updatedBy;
    data['service_charge'] = this.serviceCharge;
    data['is_active'] = this.isActive;
    data['item_name'] = this.itemName;
    data['is_all_included'] = this.isAllIncluded;
    data['image_path'] = this.imagePath;
    return data;
  }
}