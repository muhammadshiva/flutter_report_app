import 'package:bas_app/features/bahan_baku/models/bahan_baku_fetch_model.dart';

class BahanBakuArgument {
  final bool? isEdit;
  final BahanBakuData? bahanBakuData;
  final ListBahanBaku? listBahanBaku;

  BahanBakuArgument({
    this.isEdit,
    this.bahanBakuData,
    this.listBahanBaku,
  });
}
