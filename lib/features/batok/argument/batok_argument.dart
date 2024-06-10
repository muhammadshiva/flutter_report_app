import 'package:bas_app/features/batok/models/batok_fetch_model.dart';

class BatokArgument {
  final bool? isEdit;
  final BatokData? batokData;
  final ListBatok? listBatokData;

  BatokArgument({
    this.isEdit,
    this.batokData,
    this.listBatokData,
  });
}
