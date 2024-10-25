import 'dart:collection';

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
        data: MixingData.fromJson(json["data"]),
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
                json["list_mixing"]!.map(
                  (x) => ListMixing.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_mixing": listMixing == null
            ? []
            : List<dynamic>.from(
                listMixing!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class ListMixing {
  int? id;
  String? tanggal;
  String? ukuranPisau;
  double? jumlahAci;
  double? jumlahCairan;
  double? jumlahArangSulawesi;
  double? jumlahArangSumatera;
  double? jumlahArangKayu;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListMixing({
    this.id,
    this.tanggal,
    this.ukuranPisau,
    this.jumlahAci,
    this.jumlahCairan,
    this.jumlahArangSulawesi,
    this.jumlahArangSumatera,
    this.jumlahArangKayu,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListMixing.fromJson(Map<String, dynamic> json) => ListMixing(
        id: json["id"],
        tanggal: json["tanggal"],
        ukuranPisau: json["ukuran_pisau"],
        jumlahAci: (json["jumlah_aci"] is int)
            ? (json["jumlah_aci"] as int).toDouble()
            : json["jumlah_aci"] as double?,
        jumlahCairan: (json["jumlah_cairan"] is int)
            ? (json["jumlah_cairan"] as int).toDouble()
            : json["jumlah_cairan"] as double?,
        jumlahArangSulawesi: (json["jumlah_arang_sulawesi"] is int)
            ? (json["jumlah_arang_sulawesi"] as int).toDouble()
            : json["jumlah_arang_sulawesi"] as double?,
        jumlahArangSumatera: (json["jumlah_arang_sumatera"] is int)
            ? (json["jumlah_arang_sumatera"] as int).toDouble()
            : json["jumlah_arang_sumatera"] as double?,
        jumlahArangKayu: (json["jumlah_arang_kayu"] is int)
            ? (json["jumlah_arang_kayu"] as int).toDouble()
            : json["jumlah_arang_kayu"] as double?,
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        listData: List<ListData>.from(
          json["list_data"].map(
            (x) => ListData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "ukuran_pisau": ukuranPisau,
        "jumlah_aci": jumlahAci,
        "jumlah_cairan": jumlahCairan,
        "jumlah_arang_sulawesi": jumlahArangSulawesi,
        "jumlah_arang_sumatera": jumlahArangSumatera,
        "jumlah_arang_kayu": jumlahArangKayu,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": List<dynamic>.from(listData?.map((x) => x.toJson()) ?? []),
      };
}
