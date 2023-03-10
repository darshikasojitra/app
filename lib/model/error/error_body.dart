class ErrorBody {
  int? status;
  String? message;
  String? errorCode;
  String? endpoiont;

  ErrorBody({
    this.status,
    this.message,
    this.errorCode,
    this.endpoiont,
  });

  ErrorBody.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['errorCode'] = errorCode;

    return data;
  }
}