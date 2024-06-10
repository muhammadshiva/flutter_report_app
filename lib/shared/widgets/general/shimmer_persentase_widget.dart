import 'package:bas_app/shared/styles/color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPersentaseWidget extends StatelessWidget {
  const ShimmerPersentaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 32.h,
                  width: 100.w,
                  color: Colors.white,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 32.h,
                  width: 100.w,
                  color: Colors.white,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 32.h,
                  width: 100.w,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        30.verticalSpace,
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  height: 15.w,
                  width: 220.w,
                ),
                5.verticalSpace,
                Container(
                  color: Colors.white,
                  height: 15.w,
                  width: 70.w,
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 57.h,
                      width: 150.w,
                    ),
                    10.horizontalSpace,
                    Container(
                      color: Colors.white,
                      height: 57.h,
                      width: 150.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        const Divider(
          thickness: 5,
          color: ColorStyle.grey,
        ),
      ],
    );
  }
}
