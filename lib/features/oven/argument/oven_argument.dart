import 'package:bas_app/features/oven/models/oven_fetch_model.dart';

class OvenArgument {
  final bool? isEdit;
  final OvenData? ovenData;
  final ListOven? listOven;

  OvenArgument({
    this.isEdit,
    this.ovenData,
    this.listOven,
  });
}
