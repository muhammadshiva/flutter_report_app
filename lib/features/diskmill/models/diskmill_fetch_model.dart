import 'package:bas_app/shared/model/list_data_model.dart';

class DiskmillFetchResponseModel {
  int? status;
  String? message;
  DiskmillData? data;

  DiskmillFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory DiskmillFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      DiskmillFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DiskmillData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DiskmillData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListDiskmill>? listDiskmill;

  DiskmillData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listDiskmill,
  });

  factory DiskmillData.fromJson(Map<String, dynamic> json) => DiskmillData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listDiskmill: json["list_diskmill"] == null
            ? []
            : List<ListDiskmill>.from(
                json["list_diskmill"]!.map((x) => ListDiskmill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_diskmill": listDiskmill == null
            ? []
            : List<dynamic>.from(listDiskmill!.map((x) => x.toJson())),
      };
}

class ListDiskmill {
  int? id;
  String? tanggal;
  String? sumberBatok;
  double? batokMasuk;
  double? hasilPisau02;
  double? hasilPisau03;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListDiskmill({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.batokMasuk,
    this.hasilPisau02,
    this.hasilPisau03,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListDiskmill.fromJson(Map<String, dynamic> json) => ListDiskmill(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        batokMasuk: (json["batok_masuk"] is int)
            ? (json["batok_masuk"] as int).toDouble()
            : json["batok_masuk"] as double?,
        hasilPisau02: (json["hasil_pisau_02"] is int)
            ? (json["hasil_pisau_02"] as int).toDouble()
            : json["hasil_pisau_02"] as double?,
        hasilPisau03: (json["hasil_pisau_03"] is int)
            ? (json["hasil_pisau_03"] as int).toDouble()
            : json["hasil_pisau_03"] as double?,
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        listData: json["list_data"] == null
            ? []
            : List<ListData>.from(
                json["list_data"]!.map((x) => ListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "batok_masuk": batokMasuk,
        "hasil_pisau_02": hasilPisau02,
        "hasil_pisau_03": hasilPisau03,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
