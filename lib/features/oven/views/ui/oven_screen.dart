import 'package:flutter/widgets.dart';

class OvenScreen extends StatelessWidget {
  const OvenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// import 'package:flutter/material.dart';

// class OvenScreen extends StatelessWidget {
//   const OvenScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           controller.titleMenu.value,
//           style: blackTextStyle.copyWith(
//             fontSize: 17.sp,
//             fontWeight: semiBold,
//           ),
//         ),
//         leading: InkWell(
//           onTap: () {
//             Get.offAllNamed(Routes.homeRoute);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//           ),
//         ),
//         actions: [
//           PopupMenuButton<String>(
//             color: ColorStyle.white,
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               PopupMenuItem<String>(
//                 value: 'export',
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 5.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SvgPicture.asset(
//                         GlobalAssetConstant.icExportFile,
//                       ),
//                       Text(
//                         'Export',
//                         style: blackTextStyle.copyWith(
//                           color: ColorStyle.black2,
//                           fontSize: 12.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//             onSelected: (String value) {
//               if (value == 'export') {}
//             },
//           ),
//         ],
//       ),
//       body: Text('Oven Screen'),
//     );
//   }
// }
