class BaseJsonResponse {
  late bool isSuccess;
  String? message;
  dynamic data;

  BaseJsonResponse({required this.isSuccess, this.message, this.data});

  BaseJsonResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}