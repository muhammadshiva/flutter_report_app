class SumberBatokFetchModel {
  int? status;
  String? message;
  List<String>? data;

  SumberBatokFetchModel({
    this.status,
    this.message,
    this.data,
  });

  factory SumberBatokFetchModel.fromJson(Map<String, dynamic> json) => SumberBatokFetchModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
