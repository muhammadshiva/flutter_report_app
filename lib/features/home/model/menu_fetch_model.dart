class MenuFetchResponseModel {
  int? status;
  String? message;
  List<MenuData>? data;

  MenuFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MenuFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      MenuFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<MenuData>.from(
                json["data"]!.map(
                  (x) => MenuData.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(
                data!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class MenuData {
  int? id;
  String? title;
  String? dateCreated;
  int? total;

  MenuData({
    this.id,
    this.title,
    this.dateCreated,
    this.total,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
        id: json["id"],
        title: json["title"],
        dateCreated: json["date_created"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date_created": dateCreated,
        "total": total,
      };
}
