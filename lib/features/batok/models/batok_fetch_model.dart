import 'package:bas_app/shared/model/list_data_model.dart';
import 'package:bas_app/shared/model/list_persentase_model.dart';

class BatokFetchResponseModel {
  int? status;
  String? message;
  BatokData? data;

  BatokFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BatokFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      BatokFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : (json["data"] is List && json["data"].isEmpty)
                ? BatokData(listBatok: [], totalData: 0)
                : BatokData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class BatokData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListPersentase>? listPersentase;
  List<String>? listSumberBatok;
  List<ListBatok>? listBatok;

  BatokData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listPersentase,
    this.listSumberBatok,
    this.listBatok,
  });

  factory BatokData.fromJson(Map<String, dynamic> json) => BatokData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listPersentase: json["list_persentase"] == null
            ? []
            : List<ListPersentase>.from(json["list_persentase"]!
                .map((x) => ListPersentase.fromJson(x))),
        listSumberBatok: json["list_sumber_batok"] == null
            ? []
            : List<String>.from(json["list_sumber_batok"]!.map((x) => x)),
        listBatok: json["list_batok"] == null
            ? []
            : List<ListBatok>.from(
                json["list_batok"]!.map((x) => ListBatok.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_persentase": listPersentase == null
            ? []
            : List<dynamic>.from(listPersentase!.map((x) => x.toJson())),
        "list_sumber_batok": listSumberBatok == null
            ? []
            : List<dynamic>.from(listSumberBatok!.map((x) => x)),
        "list_batok": listBatok == null
            ? []
            : List<dynamic>.from(listBatok!.map((x) => x.toJson())),
      };
}

class ListBatok {
  int? id;
  String? jenisMasukan;
  String? tanggal;
  String? sumberBatok;
  double? jumlahBatok;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListBatok({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.jumlahBatok,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListBatok.fromJson(Map<String, dynamic> json) => ListBatok(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        jumlahBatok: (json["jumlah_batok"] is int)
            ? (json["jumlah_batok"] as int).toDouble()
            : json["jumlah_batok"] as double?,
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
        "jumlah_batok": jumlahBatok,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
