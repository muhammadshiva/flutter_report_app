class UserDeleteResponseModel {
  int? status;
  String? message;
  UserDeleteData? data;

  UserDeleteResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      UserDeleteResponseModel(
        status: json["status"],
        message: json["message"],
        data: UserDeleteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserDeleteData {
  UserDeleteData();

  factory UserDeleteData.fromJson(Map<String, dynamic> json) =>
      UserDeleteData();

  Map<String, dynamic> toJson() => {};
}
