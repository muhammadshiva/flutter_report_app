import 'package:bas_app/features/mixing/models/mixing_fetch_model.dart';

class MixingArgument {
  final bool? isEdit;
  final MixingData? mixingData;
  final ListMixing? listMixing;

  MixingArgument({
    this.isEdit,
    this.mixingData,
    this.listMixing,
  });
}
