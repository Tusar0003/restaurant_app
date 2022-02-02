class Profile {
  String? mobileNumber;
  String? userName;
  String? email;
  String? address;
  String? profileImagePath;
  String? firebaseToken;
  int? isActive;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  Profile(
      {this.mobileNumber,
        this.userName,
        this.email,
        this.address,
        this.profileImagePath,
        this.firebaseToken,
        this.isActive,
        this.createdBy,
        this.createdTime,
        this.updatedBy,
        this.updatedTime});

  Profile.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    userName = json['user_name'];
    email = json['email'];
    address = json['address'];
    profileImagePath = json['profile_image_path'];
    firebaseToken = json['firebase_token'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_number'] = this.mobileNumber;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['address'] = this.address;
    data['profile_image_path'] = this.profileImagePath;
    data['firebase_token'] = this.firebaseToken;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_time'] = this.createdTime;
    data['updated_by'] = this.updatedBy;
    data['updated_time'] = this.updatedTime;
    return data;
  }
}
