class Notification {
  int? id;
  String? title;
  String? body;
  String? userName;
  bool? isSent;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  Notification(
      {this.id,
        this.title,
        this.body,
        this.userName,
        this.isSent,
        this.createdBy,
        this.createdTime,
        this.updatedBy,
        this.updatedTime});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isSent = json['is_sent'];
    createdBy = json['created_by'];
    createdTime = json['created_time'];
    updatedBy = json['updated_by'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['user_name'] = this.userName;
    // data['is_sent'] = this.isSent;
    // data['created_by'] = this.createdBy;
    // data['created_time'] = this.createdTime;
    // data['updated_by'] = this.updatedBy;
    // data['updated_time'] = this.updatedTime;
    return data;
  }
}
