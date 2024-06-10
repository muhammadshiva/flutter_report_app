class ListData {
  String? jenisData;
  int? jumlah;

  ListData({
    this.jenisData,
    this.jumlah,
  });

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        jenisData: json["jenis_data"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "jenis_data": jenisData,
        "jumlah": jumlah,
      };
}
