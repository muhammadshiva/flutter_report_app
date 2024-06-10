class AyakManualPostResponseModel {
  int? status;
  String? message;
  Data? data;

  AyakManualPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AyakManualPostResponseModel.fromJson(Map<String, dynamic> json) =>
      AyakManualPostResponseModel(
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
  int? id;
  String? sumberBatok;
  double? jumlahBatok;
  double? jumlahBatokMentah;
  double? jumlahGranul;
  String? keterangan;

  Data({
    this.id,
    this.sumberBatok,
    this.jumlahBatok,
    this.jumlahBatokMentah,
    this.jumlahGranul,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sumberBatok: json["sumber_batok"],
        jumlahBatok:
            json["jumlah_batok"] != null ? double.tryParse(json["jumlah_batok"].toString()) : null,
        jumlahBatokMentah: json["jumlah_batok_mentah"] != null
            ? double.tryParse(json["jumlah_batok_mentah"].toString())
            : null,
        jumlahGranul: json["jumlah_granul"] != null
            ? double.tryParse(json["jumlah_granul"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sumber_batok": sumberBatok,
        "jumlah_batok": jumlahBatok,
        "jumlah_batok_mentah": jumlahBatokMentah,
        "jumlah_granul": jumlahGranul,
        "keterangan": keterangan,
      };
}
