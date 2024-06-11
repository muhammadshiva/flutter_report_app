import 'package:bas_app/features/diskmill/models/diskmill_fetch_model.dart';

class DiskmillArgument {
  final bool? isEdit;
  final DiskmillData? diskmillData;
  final ListDiskmill? listDiskmill;

  DiskmillArgument({
    this.isEdit,
    this.diskmillData,
    this.listDiskmill,
  });
}
