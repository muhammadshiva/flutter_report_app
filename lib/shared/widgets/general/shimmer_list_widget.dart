import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.w, right: 7.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 20.w,
                    width: 125.w,
                    color: Colors.white,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 30.w,
                    width: 120.w,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          component(),
          component(),
          component(),
          component(),
          component(),
          component(),
        ],
      ),
    );
  }

  Widget component() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 13.w,
                        width: 100.w,
                        color: Colors.white,
                      ),
                      5.verticalSpace,
                      Container(
                        height: 11.w,
                        width: 120.w,
                        color: Colors.white,
                      ),
                      5.verticalSpace,
                      Container(
                        height: 11.w,
                        width: 150.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  7.horizontalSpace,
                  Container(
                    margin: EdgeInsets.only(right: 7.w),
                    height: 14.w,
                    width: 80.w,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
