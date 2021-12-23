class BaseResponse {

  bool isSuccess;
  String? message;
  dynamic data;

  BaseResponse(this.isSuccess, this.message, this.data);
}