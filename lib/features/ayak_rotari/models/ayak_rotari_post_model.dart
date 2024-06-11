class AyakRotariPostResponseModel {
  int? status;
  String? message;
  Data? data;

  AyakRotariPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AyakRotariPostResponseModel.fromJson(Map<String, dynamic> json) =>
      AyakRotariPostResponseModel(
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
  DateTime? tanggal;
  String? sumberBatok;
  double? batokMasuk;
  double? batokKotor;
  double? hasilBatok;
  double? hasilAbu;
  String? keterangan;

  Data({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.batokMasuk,
    this.batokKotor,
    this.hasilBatok,
    this.hasilAbu,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal:
            json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        sumberBatok: json["sumber_batok"],
        batokMasuk: json["batok_masuk"] != null
            ? double.tryParse(json["batok_masuk"].toString())
            : null,
        batokKotor: json["batok_kotor"] != null
            ? double.tryParse(json["batok_kotor"].toString())
            : null,
        hasilBatok: json["hasil_batok"] != null
            ? double.tryParse(json["hasil_batok"].toString())
            : null,
        hasilAbu: json["hasil_abu"] != null
            ? double.tryParse(json["hasil_abu"].toString())
            : null,
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "batok_kotor": batokKotor,
        "hasil_batok": hasilBatok,
        "hasil_abu": hasilAbu,
        "keterangan": keterangan,
      };
}
