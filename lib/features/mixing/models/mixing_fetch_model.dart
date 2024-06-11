import 'package:bas_app/shared/model/list_data_model.dart';

class MixingFetchResponseModel {
  int? status;
  String? message;
  MixingData? data;

  MixingFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MixingFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      MixingFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : MixingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class MixingData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListMixing>? listMixing;

  MixingData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listMixing,
  });

  factory MixingData.fromJson(Map<String, dynamic> json) => MixingData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listMixing: json["list_mixing"] == null
            ? []
            : List<ListMixing>.from(
                json["list_mixing"]!.map((x) => ListMixing.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_mixing": listMixing == null
            ? []
            : List<dynamic>.from(listMixing!.map((x) => x.toJson())),
      };
}

class ListMixing {
  int? id;
  String? tanggal;
  String? sumberBatok;
  double? ukuranPisau;
  double? jumlahArang;
  double? jumlahAci;
  double? jumlahCairan;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListMixing({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.ukuranPisau,
    this.jumlahArang,
    this.jumlahAci,
    this.jumlahCairan,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListMixing.fromJson(Map<String, dynamic> json) => ListMixing(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        ukuranPisau: (json["ukuran_pisau"] is int)
            ? (json["ukuran_pisau"] as int).toDouble()
            : json["ukuran_pisau"] as double?,
        jumlahArang: (json["jumlah_arang"] is int)
            ? (json["jumlah_arang"] as int).toDouble()
            : json["jumlah_arang"] as double?,
        jumlahAci: (json["jumlah_aci"] is int)
            ? (json["jumlah_aci"] as int).toDouble()
            : json["jumlah_aci"] as double?,
        jumlahCairan: (json["jumlah_cairan"] is int)
            ? (json["jumlah_cairan"] as int).toDouble()
            : json["jumlah_cairan"] as double?,
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
        "ukuran_pisau": ukuranPisau,
        "jumlah_arang": jumlahArang,
        "jumlah_aci": jumlahAci,
        "jumlah_cairan": jumlahCairan,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
