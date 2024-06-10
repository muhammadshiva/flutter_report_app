class BatokPostResponseModel {
  int? status;
  String? message;
  BatokPostData? data;

  BatokPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BatokPostResponseModel.fromJson(Map<String, dynamic> json) => BatokPostResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BatokPostData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class BatokPostData {
  int? id;
  String? jenisMasukan;
  DateTime? tanggal;
  String? sumberBatok;
  int? jumlahBatok;
  String? keterangan;
  String? updatedAt;
  String? createdAt;

  BatokPostData({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.jumlahBatok,
    this.keterangan,
    this.updatedAt,
    this.createdAt,
  });

  factory BatokPostData.fromJson(Map<String, dynamic> json) => BatokPostData(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        sumberBatok: json["sumber_batok"],
        jumlahBatok:
            json["jumlah_batok"] != null ? int.tryParse(json["jumlah_batok"].toString()) : null,
        keterangan: json["keterangan"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_masukan": jenisMasukan,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "sumber_batok": sumberBatok,
        "jumlah_batok": jumlahBatok,
        "keterangan": keterangan,
        "updated_at": updatedAt,
        "created_at": createdAt,
      };
}
