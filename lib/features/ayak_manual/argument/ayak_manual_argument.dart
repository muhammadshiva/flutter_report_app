import 'package:bas_app/features/ayak_manual/models/ayak_manual_fetch_model.dart';

class AyakManualArgument {
  final bool? isEdit;
  final AyakManualData? ayakManualData;
  final ListAyakManual? listAyakManual;

  AyakManualArgument({
    this.isEdit,
    this.ayakManualData,
    this.listAyakManual,
  });
}
