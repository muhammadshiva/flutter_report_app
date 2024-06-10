import 'package:bas_app/shared/model/list_data_model.dart';
import 'package:bas_app/shared/model/list_persentase_model.dart';

class BahanBakuFetchResponseModel {
  int? status;
  String? message;
  BahanBakuData? data;

  BahanBakuFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory BahanBakuFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      BahanBakuFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BahanBakuData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class BahanBakuData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListPersentase>? listPersentase;
  List<String>? listSumberBatok;
  List<ListBahanBaku>? listBahanBaku;

  BahanBakuData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listPersentase,
    this.listSumberBatok,
    this.listBahanBaku,
  });

  factory BahanBakuData.fromJson(Map<String, dynamic> json) => BahanBakuData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listPersentase: json["list_persentase"] == null
            ? []
            : List<ListPersentase>.from(
                json["list_persentase"]!.map((x) => ListPersentase.fromJson(x))),
        listSumberBatok: json["list_sumber_batok"] == null
            ? []
            : List<String>.from(json["list_sumber_batok"]!.map((x) => x)),
        listBahanBaku: json["list_bahan_baku"] == null
            ? []
            : List<ListBahanBaku>.from(
                json["list_bahan_baku"]!.map((x) => ListBahanBaku.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data": totalData,
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_persentase": listPersentase == null
            ? []
            : List<dynamic>.from(listPersentase!.map((x) => x.toJson())),
        "list_sumber_batok":
            listSumberBatok == null ? [] : List<dynamic>.from(listSumberBatok!.map((x) => x)),
        "list_bahan_baku":
            listBahanBaku == null ? [] : List<dynamic>.from(listBahanBaku!.map((x) => x.toJson())),
      };
}

class ListBahanBaku {
  int? id;
  String? jenisMasukan;
  String? tanggal;
  String? sumberBatok;
  String? bahanBaku;
  int? jumlah;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListBahanBaku({
    this.id,
    this.jenisMasukan,
    this.tanggal,
    this.sumberBatok,
    this.bahanBaku,
    this.jumlah,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListBahanBaku.fromJson(Map<String, dynamic> json) => ListBahanBaku(
        id: json["id"],
        jenisMasukan: json["jenis_masukan"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        bahanBaku: json["bahan_baku"],
        jumlah: json["jumlah"],
        keterangan: json["keterangan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        listData: json["list_data"] == null
            ? []
            : List<ListData>.from(json["list_data"]!.map((x) => ListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_masukan": jenisMasukan,
        "tanggal": tanggal,
        "sumber_batok": sumberBatok,
        "bahan_baku": bahanBaku,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null ? [] : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
