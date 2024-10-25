class MixingPostResponseModel {
  int? status;
  String? message;
  Data? data;

  MixingPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MixingPostResponseModel.fromJson(Map<String, dynamic> json) =>
      MixingPostResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? tanggal;
  double? ukuranPisau;
  double? jumlahArangSulawesi;
  double? jumlahArangSumatera;
  double? jumlahArangKayu;
  double? jumlahAci;
  double? jumlahCairan;
  String? keterangan;

  Data({
    this.id,
    this.tanggal,
    this.ukuranPisau,
    this.jumlahArangSulawesi,
    this.jumlahArangSumatera,
    this.jumlahArangKayu,
    this.jumlahAci,
    this.jumlahCairan,
    this.keterangan,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tanggal: json["tanggal"],
        ukuranPisau: json["ukuran_pisau"].toDouble(),
        jumlahArangSulawesi: json["jumlah_arang_sulawesi"],
        jumlahArangSumatera: json["jumlah_arang_sumatera"],
        jumlahArangKayu: json["jumlah_arang_kayu"],
        jumlahAci: json["jumlah_aci"],
        jumlahCairan: json["jumlah_cairan"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal": tanggal,
        "ukuran_pisau": ukuranPisau,
        "jumlah_arang_sulawesi": jumlahArangSulawesi,
        "jumlah_arang_sumatera": jumlahArangSumatera,
        "jumlah_arang_kayu": jumlahArangKayu,
        "jumlah_aci": jumlahAci,
        "jumlah_cairan": jumlahCairan,
        "keterangan": keterangan,
      };
}
