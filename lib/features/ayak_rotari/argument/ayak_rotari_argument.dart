import 'package:bas_app/features/ayak_rotari/models/ayak_rotari_fetch_model.dart';

class AyakRotariArgument {
  final bool? isEdit;
  final AyakRotariData? ayakRotariData;
  final ListAyakRotari? listAyakRotari;

  AyakRotariArgument({
    this.isEdit,
    this.ayakRotariData,
    this.listAyakRotari,
  });
}
