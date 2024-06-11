import 'package:bas_app/shared/model/list_data_model.dart';

class AyakRotariFetchResponseModel {
  int? status;
  String? message;
  AyakRotariData? data;

  AyakRotariFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AyakRotariFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      AyakRotariFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : AyakRotariData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AyakRotariData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListAyakRotari>? listAyakRotari;

  AyakRotariData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listAyakRotari,
  });

  factory AyakRotariData.fromJson(Map<String, dynamic> json) => AyakRotariData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listAyakRotari: json["list_ayak_rotari"] == null
            ? []
            : List<ListAyakRotari>.from(json["list_ayak_rotari"]!
                .map((x) => ListAyakRotari.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_ayak_rotari": listAyakRotari == null
            ? []
            : List<dynamic>.from(listAyakRotari!.map((x) => x.toJson())),
      };
}

class ListAyakRotari {
  int? id;
  String? tanggal;
  String? sumberBatok;
  int? batokMasuk;
  int? batokKotor;
  int? hasilBatok;
  int? hasilAbu;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListAyakRotari({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.batokMasuk,
    this.batokKotor,
    this.hasilBatok,
    this.hasilAbu,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListAyakRotari.fromJson(Map<String, dynamic> json) => ListAyakRotari(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        batokMasuk: json["batok_masuk"],
        batokKotor: json["batok_kotor"],
        hasilBatok: json["hasil_batok"],
        hasilAbu: json["hasil_abu"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        listData: json["list_data"] == null
            ? []
            : List<ListData>.from(
                json["list_data"]!.map(
                  (x) => ListData.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "batok_kotor": batokKotor,
        "hasil_batok": hasilBatok,
        "hasil_abu": hasilAbu,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(
                listData!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}
