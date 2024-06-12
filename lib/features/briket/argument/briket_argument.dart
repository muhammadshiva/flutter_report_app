import 'package:bas_app/features/briket/models/briket_fetch_model.dart';

class BriketArgument {
  final bool? isEdit;
  final BriketData? briketData;
  final ListBriket? listBriket;

  BriketArgument({
    this.isEdit,
    this.briketData,
    this.listBriket,
  });
}
