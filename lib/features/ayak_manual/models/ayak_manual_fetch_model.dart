import 'package:bas_app/shared/model/list_data_model.dart';

class AyakManualFetchResponseModel {
  int? status;
  String? message;
  AyakManualData? data;

  AyakManualFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AyakManualFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      AyakManualFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null ? null : AyakManualData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AyakManualData {
  int? totalData;
  String? tanggalDitambahkan;
  List<ListAyakManual>? listAyakManual;

  AyakManualData({
    this.totalData,
    this.tanggalDitambahkan,
    this.listAyakManual,
  });

  factory AyakManualData.fromJson(Map<String, dynamic> json) => AyakManualData(
        totalData: json["total_data"],
        tanggalDitambahkan: json["tanggal_ditambahkan"],
        listAyakManual: json["list_ayak_manual"] == null
            ? []
            : List<ListAyakManual>.from(
                json["list_ayak_manual"]!.map(
                  (x) => ListAyakManual.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "tanggal_ditambahkan": tanggalDitambahkan,
        "list_ayak_manual": listAyakManual == null
            ? []
            : List<dynamic>.from(
                listAyakManual!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class ListAyakManual {
  int? id;
  String? tanggal;
  String? sumberBatok;
  double? jumlahBatok;
  double? jumlahBatokMentah;
  double? jumlahGranul;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  List<ListData>? listData;

  ListAyakManual({
    this.id,
    this.tanggal,
    this.sumberBatok,
    this.jumlahBatok,
    this.jumlahBatokMentah,
    this.jumlahGranul,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
    this.listData,
  });

  factory ListAyakManual.fromJson(Map<String, dynamic> json) => ListAyakManual(
        id: json["id"],
        tanggal: json["tanggal"],
        sumberBatok: json["sumber_batok"],
        jumlahBatok: (json["jumlah_batok"] is int)
            ? (json["jumlah_batok"] as int).toDouble()
            : json["jumlah_batok"] as double?,
        jumlahBatokMentah: (json["jumlah_batok_mentah"] is int)
            ? (json["jumlah_batok_mentah"] as int).toDouble()
            : json["jumlah_batok_mentah"] as double?,
        jumlahGranul: (json["jumlah_granul"] is int)
            ? (json["jumlah_granul"] as int).toDouble()
            : json["jumlah_granul"] as double?,
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
        "jumlah_batok": jumlahBatok,
        "jumlah_batok_mentah": jumlahBatokMentah,
        "jumlah_granul": jumlahGranul,
        "keterangan": keterangan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "list_data": listData == null
            ? []
            : List<dynamic>.from(listData!.map((x) => x.toJson())),
      };
}
