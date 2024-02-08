

class ApiError {
  String response;
  String error;

  ApiError({required this.response, required this.error,});

  factory ApiError.fromJson(Map<String, dynamic> json) {

    return ApiError(
      response: json['Response'],
      error: json['Error'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Response'] = response;
    data['Error'] = error;
    return data;
  }

}