import 'package:bas_app/shared/model/list_data_model.dart';
import 'package:bas_app/shared/model/list_persentase_model.dart';

class OvenFetchResponseModel {
  int? status;
  String? message;
  OvenData? data;

  OvenFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory OvenFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      OvenFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : OvenData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class OvenData {
  int? totalData;
  DateTime? tanggalDitambahkan;
  List<ListPersentase>? listPersentase;
  List<ListOven>? listOven;

  OvenData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listPersentase,
    this.listOven,
  });

  factory OvenData.fromJson(Map<String, dynamic> json) => OvenData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"] == null
            ? null
            : DateTime.parse(json["tanggal_ditambahkan"]),
        listPersentase: json["list_persentase"] == null
            ? []
            : List<ListPersentase>.from(json["list_persentase"]!
                .map((x) => ListPersentase.fromJson(x))),
        listOven: json["list_oven"] == null
            ? []
            : List<ListOven>.from(
                json["list_oven"]!.map((x) => ListOven.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan":
            "${tanggalDitambahkan!.year.toString().padLeft(4, '0')}-${tanggalDitambahkan!.month.toString().padLeft(2, '0')}-${tanggalDitambahkan!.day.toString().padLeft(2, '0')}",
        "list_persentase": listPersentase == null
            ? []
            : List<dynamic>.from(listPersentase!.map((x) => x.toJson())),
        "list_oven": listOven == null
            ? []
            : List<dynamic>.from(listOven!.map((x) => x.toJson())),
      };
}

class ListOven {
  int? id;
  String? jenisMasukan;
  String? tanggal;
  String? sumberBatok;
  String? jenisBriket;
  double? pengovenan;
  double? pendinginan;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListOven({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.jenisBriket,
    this.pengovenan,
    this.pendinginan,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListOven.fromJson(Map<String, dynamic> json) => ListOven(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        jenisBriket: json["jenis_briket"],
        pengovenan: (json["pengovenan"] is int)
            ? (json["pengovenan"] as int).toDouble()
            : json["pengovenan"] as double?,
        pendinginan: (json["pendinginan"] is int)
            ? (json["pendinginan"] as int).toDouble()
            : json["pendinginan"] as double?,
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
        "pengovenan": pengovenan,
        "pendinginan": pendinginan,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
