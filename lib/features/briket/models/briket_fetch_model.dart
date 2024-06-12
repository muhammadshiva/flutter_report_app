import 'package:bas_app/shared/model/list_data_model.dart';
import 'package:bas_app/shared/model/list_persentase_model.dart';

class BriketFetchResponseModel {
  int? status;
  String? message;
  BriketData? data;

  BriketFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BriketFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      BriketFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BriketData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class BriketData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListPersentase>? listPersentase;
  List<ListBriket>? listBriket;

  BriketData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listPersentase,
    this.listBriket,
  });

  factory BriketData.fromJson(Map<String, dynamic> json) => BriketData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listPersentase: json["list_persentase"] == null
            ? []
            : List<ListPersentase>.from(json["list_persentase"]!
                .map((x) => ListPersentase.fromJson(x))),
        listBriket: json["list_briket"] == null
            ? []
            : List<ListBriket>.from(
                json["list_briket"]!.map((x) => ListBriket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_persentase": listPersentase == null
            ? []
            : List<dynamic>.from(listPersentase!.map((x) => x.toJson())),
        "list_briket": listBriket == null
            ? []
            : List<dynamic>.from(listBriket!.map((x) => x.toJson())),
      };
}

class ListBriket {
  int? id;
  String? jenisMasukan;
  String? tanggal;
  String? sumberBatok;
  String? jenisBriket;
  double? stok;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListBriket({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.jenisBriket,
    this.stok,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListBriket.fromJson(Map<String, dynamic> json) => ListBriket(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        jenisBriket: json["jenis_briket"],
        stok: (json["stok"] is int)
            ? (json["stok"] as int).toDouble()
            : json["stok"] as double?,
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
        "jenis_masukan": jenisMasukan,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "jenis_briket": jenisBriket,
        "stok": stok,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
