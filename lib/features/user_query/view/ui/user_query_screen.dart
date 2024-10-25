import 'package:bas_app/constants/global_asset_constant.dart';
import 'package:bas_app/features/user/controllers/user_controller.dart';
import 'package:bas_app/features/user_query/controllers/user_query_controller.dart';
import 'package:bas_app/shared/styles/color_style.dart';
import 'package:bas_app/shared/styles/google_text_style.dart';
import 'package:bas_app/shared/widgets/custom_button/dropdown_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_labe_top_widget.dart';
import 'package:bas_app/shared/widgets/custom_text_field/text_field_widget_custom.dart';
import 'package:bas_app/shared/widgets/general/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserQueryScreen extends StatelessWidget {
  const UserQueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = UserController.to;
    var queryController = UserQueryController.to;

    return Scaffold(
      appBar: AppBarCustom(
        title: controller.isEdit.isTrue ? 'Edit Akses' : 'Tambah Pengguna',
        onBack: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.w),
        child: ListView(
          children: [
            TextFieldLabelTopWidget(
              title: 'Name',
              hint: 'Name',
              initialValue: queryController.nameTxt.value,
              onChanged: (value) {
                queryController.nameTxt.value = value ?? '';
              },
              errorText: queryController.nameError,
            ),
            15.verticalSpace,
            TextFieldLabelTopWidget(
              title: 'Username',
              hint: 'Username',
              initialValue: queryController.usernameTxt.value,
              onChanged: (value) {
                queryController.usernameTxt.value = value ?? '';
              },
              errorText: queryController.usernameError,
            ),
            15.verticalSpace,
            TextFieldLabelTopWidget(
              title: 'Email',
              hint: 'Email',
              initialValue: queryController.emailTxt.value,
              onChanged: (value) {
                queryController.emailTxt.value = value ?? '';
              },
              errorText: queryController.emailError,
            ),

            15.verticalSpace,

            Text(
              'Position',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14.sp,
                color: const Color(0xffA3A3A3),
              ),
            ),
            5.verticalSpace,

            Obx(
              () => DropdownWidget(
                hinText: 'Pilih Position',
                initialValue: queryController.positionTxt.value,
                listItem: queryController.positionList,
                onChanged: (value) {
                  queryController.positionTxt.value = value ?? '';
                },
                errorText: queryController.positionError,
              ),
            ),

            15.verticalSpace,

            //^ Current Password
            Text(
              'Password',
              style: blackTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14.sp,
                color: const Color(0xffA3A3A3),
              ),
            ),
            5.verticalSpace,
            Obx(
              () => SizedBox(
                height:
                    queryController.currentPasswordError.isEmpty ? 42.w : 70.w,
                child: TextFieldWidget(
                  controller: queryController.currentPassword,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: queryController.isShowCurrentPassword.isTrue
                      ? false
                      : true,
                  hint: 'Password',
                  hintStyle: greyTextStyle,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                  maxLines: 1,
                  errorText: queryController.currentPasswordError.value,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 12.h,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (queryController.isShowCurrentPassword.value ==
                            false) {
                          queryController.isShowCurrentPassword.value = true;
                        } else {
                          queryController.isShowCurrentPassword.value = false;
                        }
                      },
                      child: Obx(
                        () => SvgPicture.asset(
                          clipBehavior: Clip.none,
                          queryController.isShowCurrentPassword.isTrue
                              ? GlobalAssetConstant.icEye
                              : GlobalAssetConstant.icEyeSlash,
                        ),
                      ),
                    ),
                  ),
                  onChange: (value) {
                    queryController.currentPasswordError.value = '';
                  },
                ),
              ),
            ),

            20.verticalSpace,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        margin: EdgeInsets.only(bottom: 10.w),
        child: ElevatedButton(
          onPressed: () {
            queryController.validate();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyle.primary,
          ),
          child: Text(
            'Simpan',
            style: blackTextStyle.copyWith(
              color: ColorStyle.white,
              fontWeight: semiBold,
            ),
          ),
        ),
      ),
    );
  }
}

//* Incoming Feature Dialog 
      // Ketika tombol ditekan, tampilkan dialog "Fitur Segera Hadir"
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15.0),
            //       ),
            //       content: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           const Icon(
            //             Icons.construction,
            //             size: 50.0,
            //             color: ColorStyle.primary,
            //           ),
            //           SizedBox(height: 15.h),
            //           // Teks untuk fitur segera hadir
            //           Text(
            //             'Fitur Segera Hadir',
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18.sp,
            //               color: Colors.black,
            //             ),
            //           ),
            //           SizedBox(height: 10.h),
            //           Text(
            //             'Fitur ini sedang dalam pengembangan dan akan tersedia segera.',
            //             style: TextStyle(
            //               fontSize: 14.sp,
            //               color: Colors.grey,
            //             ),
            //             textAlign: TextAlign.center,
            //           ),
            //         ],
            //       ),
            //       actions: [
            //         // Tombol OK untuk menutup dialog
            //         TextButton(
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: Text(
            //             'OK',
            //             style: blackTextStyle.copyWith(
            //               color: ColorStyle.primary,
            //             ),
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // );
          

            // 15.verticalSpace,
            // //^ New Password
            // Text(
            //   'New Password',
            //   style: blackTextStyle.copyWith(
            //     fontWeight: medium,
            //     fontSize: 14.sp,
            //     color: const Color(0xffA3A3A3),
            //   ),
            // ),
            // 5.verticalSpace,
            // Obx(
            //   () => TextFieldWidget(
            //     controller: queryController.newPassword,
            //     keyboardType: TextInputType.visiblePassword,
            //     isPassword:
            //         queryController.isShowNewPassword.isTrue ? false : true,
            //     hint: 'New Password',
            //     hintStyle: greyTextStyle,
            //     contentPadding:
            //         EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
            //     maxLines: 1,
            //     suffixIcon: Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 8.w,
            //         vertical: 12.h,
            //       ),
            //       child: InkWell(
            //         onTap: () {
            //           if (queryController.isShowNewPassword.value == false) {
            //             queryController.isShowNewPassword.value = true;
            //           } else {
            //             queryController.isShowNewPassword.value = false;
            //           }
            //         },
            //         child: Obx(
            //           () => SvgPicture.asset(
            //             clipBehavior: Clip.none,
            //             queryController.isShowNewPassword.isTrue
            //                 ? GlobalAssetConstant.icEye
            //                 : GlobalAssetConstant.icEyeSlash,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // 15.verticalSpace,
            // //^ Repeat Password
            // Text(
            //   'Repeat Password',
            //   style: blackTextStyle.copyWith(
            //     fontWeight: medium,
            //     fontSize: 14.sp,
            //     color: const Color(0xffA3A3A3),
            //   ),
            // ),
            // 5.verticalSpace,
            // Obx(
            //   () => TextFieldWidget(
            //     controller: queryController.repeatPassword,
            //     keyboardType: TextInputType.visiblePassword,
            //     isPassword:
            //         queryController.isShowRepeatPassword.isTrue ? false : true,
            //     hint: 'New Password',
            //     hintStyle: greyTextStyle,
            //     contentPadding:
            //         EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
            //     maxLines: 1,
            //     suffixIcon: Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 8.w,
            //         vertical: 12.h,
            //       ),
            //       child: InkWell(
            //         onTap: () {
            //           if (queryController.isShowRepeatPassword.value == false) {
            //             queryController.isShowRepeatPassword.value = true;
            //           } else {
            //             queryController.isShowRepeatPassword.value = false;
            //           }
            //         },
            //         child: Obx(
            //           () => SvgPicture.asset(
            //             clipBehavior: Clip.none,
            //             queryController.isShowRepeatPassword.isTrue
            //                 ? GlobalAssetConstant.icEye
            //                 : GlobalAssetConstant.icEyeSlash,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // 15.verticalSpace,

            //^ Profile Picture
            // Text(
            //   'Profile Picture',
            //   style: blackTextStyle.copyWith(
            //     fontWeight: medium,
            //     fontSize: 14.sp,
            //     color: const Color(0xffA3A3A3),
            //   ),
            // ),
            // 2.verticalSpace,
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: ElevatedButton(
            //     onPressed: queryController.pickImage,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: ColorStyle.b4,
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         const Icon(
            //           Icons.photo,
            //           color: ColorStyle.white,
            //         ),
            //         5.horizontalSpace,
            //         Text(
            //           'Pick Image from Gallery',
            //           style: blackTextStyle.copyWith(
            //             color: ColorStyle.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // 15.verticalSpace,
            // // Display selected image if exists
            // Obx(() {
            //   if (queryController.selectedImage.value != null) {
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Selected Image',
            //           style: blackTextStyle.copyWith(
            //             fontWeight: medium,
            //             fontSize: 12.sp,
            //             color: const Color(0xffA3A3A3),
            //           ),
            //         ),
            //         10.verticalSpace,
            //         Image.file(
            //           File(queryController.selectedImage.value!.path),
            //           width: 150.w,
            //           height: 150.h,
            //           fit: BoxFit.cover,
            //         ),
            //       ],
            //     );
            //   } else {
            //     return Text(
            //       'No Image Selected',
            //       style: greyTextStyle.copyWith(
            //         fontSize: 12.sp,
            //       ),
            //     );
            //   }
            // }),