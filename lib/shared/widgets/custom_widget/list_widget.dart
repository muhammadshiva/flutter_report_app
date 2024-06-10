import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({
    super.key,
    this.onRefresh,
    required this.itemCount,
    required this.itemBuilder,
  });

  final Future<void> Function()? onRefresh;
  final RxInt itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Scrollbar(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: RefreshIndicator(
            onRefresh: widget.onRefresh ?? () async {},
            child: Obx(
              () => ListView.builder(
                itemCount: widget.itemCount.value,
                itemBuilder: widget.itemBuilder,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
