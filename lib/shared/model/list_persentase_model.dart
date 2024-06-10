class ListPersentase {
  String? jenisPersentase;
  double? persentase;

  ListPersentase({
    this.jenisPersentase,
    this.persentase,
  });

  factory ListPersentase.fromJson(Map<String, dynamic> json) => ListPersentase(
        jenisPersentase: json["jenis_persentase"],
        persentase: json["persentase"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "jenis_persentase": jenisPersentase,
        "persentase": persentase,
      };
}
