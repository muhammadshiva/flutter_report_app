class DiskmillDeleteResponseModel {
  int? status;
  String? message;
  Data? data;

  DiskmillDeleteResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory DiskmillDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      DiskmillDeleteResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
