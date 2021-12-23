class Category {
  String? categoryCode;
  String? categoryName;
  String? imagePath;
  int? isActive;
  int? totalItemNo;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  Category({
    this.categoryCode,
    this.categoryName,
    this.imagePath,
    this.isActive,
    this.totalItemNo,
    this.createdBy,
    this.createdTime,
    this.updatedBy,
    this.updatedTime});

  Category.fromJson(Map<String, dynamic> json) {
    categoryCode = json['category_code'];
    categoryName = json['category_name'];
    imagePath = json['image_path'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
    totalItemNo = json['total_item_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_code'] = this.categoryCode;
    data['category_name'] = this.categoryName;
    data['image_path'] = this.imagePath;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    data['total_item_no'] = this.totalItemNo;
    return data;
  }
}