class BahanBakuDeleteResponseModel {
  int? status;
  String? message;
  Data? data;

  BahanBakuDeleteResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BahanBakuDeleteResponseModel.fromJson(Map<String, dynamic> json) =>
      BahanBakuDeleteResponseModel(
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
