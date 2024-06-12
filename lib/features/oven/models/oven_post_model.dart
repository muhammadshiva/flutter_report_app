class OvenPostResponseModel {
  int? status;
  String? message;
  Data? data;

  OvenPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory OvenPostResponseModel.fromJson(Map<String, dynamic> json) =>
      OvenPostResponseModel(
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
  String? jenisMasukan;
  DateTime? tanggal;
  String? sumberBatok;
  String? jenisBriket;
  double? pengovenan;
  double? pendinginan;
  String? keterangan;

  Data({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.jenisBriket,
    this.pengovenan,
    this.pendinginan,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        sumberBatok: json["sumber_batok"],
        jenisBriket: json["jenis_briket"],
        pengovenan: json["pengovenan"] != null
            ? double.tryParse(json["pengovenan"].toString())
            : null,
        pendinginan: json["pendinginan"] != null
            ? double.tryParse(json["pendinginan"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_masukan": jenisMasukan,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "sumber_batok": sumberBatok,
        "jenis_briket": jenisBriket,
        "pengovenan": pengovenan,
        "pendinginan": pendinginan,
        "keterangan": keterangan,
      };
}
