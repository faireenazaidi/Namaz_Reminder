import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
import 'package:namaz_reminders/Setting/SettingController.dart';
import '../../AppManager/dialogs.dart';
import '../../DashBoard/dashboardController.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';

// class HijriDateView extends GetView<SettingController> {
//   @override
//   Widget build(BuildContext context) {
//     final HijriController hijriController = Get.put(HijriController());
//     final DashBoardController dashboardController = Get.put(DashBoardController());
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           title: Text('Hijri Date Adjustment', style: MyTextTheme.mediumBCD),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1.0),
//             child: Divider(
//               height: 1.5,
//               color: AppColor.packageGray,
//             ),
//           ),
//           leading: InkWell(
//             onTap: () {
//               Get.back(
//                 //     () => SettingView(),
//                 // transition: Transition.rightToLeft,
//                 // duration: Duration(milliseconds: 500),
//                 // curve: Curves.ease,
//               );
//             },
//             child: const Icon(Icons.arrow_back_ios_new, size: 20),
//           ),
//         ),
//         // body: Padding(
//         //   padding: const EdgeInsets.all(16.0),
//         //   child: SingleChildScrollView(
//         //     child: Column(
//         //       children: [
//         //         GetBuilder<HijriController>(
//         //             builder: (_) {
//         //               return ListView.builder(
//         //                   shrinkWrap: true,
//         //                   itemCount: hijriController.hijriDateAdjustment.length,
//         //                   itemBuilder: (context, index) {
//         //                     // Get the current day mapping
//         //                     var day = hijriController.hijriDateAdjustment[index];
//         //                     return Obx(()=>
//         //                         ListTile(
//         //                           title: Text(
//         //                             day['name'],
//         //                             style: TextStyle(
//         //                               fontWeight: hijriController.selectedId.value == day['id']
//         //                                   ? FontWeight.bold
//         //                                   : FontWeight.normal,
//         //                             ),
//         //                           ),
//         //                           trailing: hijriController.selectedId.value == day['id']
//         //                               ? const Icon(Icons.check, color: Colors.green)
//         //                               : null,
//         //                           onTap: () {
//         //                             hijriController.updateSelectedId(day['id']);
//         //                             hijriController.registerUser();
//         //                             hijriController.selectItem(day['id']);
//         //                           },
//         //                         ),
//         //                     );
//         //
//         //                   });
//         //             }
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         body: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Dialogs.showCustomDialog(
//                   context: context,
//                   content: GetBuilder<HijriController>(
//                     builder: (hijriController) {
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: hijriController.hijriDateAdjustment.length,
//                         itemBuilder: (context, index) {
//                           // Get the current day mapping
//                           var day = hijriController.hijriDateAdjustment[index];
//                           return Obx(() => ListTile(
//                             title: Container(
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: hijriController.selectedId.value == day['id']
//                                     ?  AppColor.color // Selected color
//                                     : Colors.white70, // Default color
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   day['name'],
//                                   style: TextStyle(
//                                     fontWeight: hijriController.selectedId.value == day['id']
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                     color: hijriController.selectedId.value == day['id']
//                                         ? Colors.white
//                                         : Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               hijriController.updateSelectedId(day['id']);
//                               hijriController.registerUser();
//                               hijriController.selectItem(day['id']);
//                             },
//                           ));
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//               child: Text("Show Bottom Sheet"),
//             ),
//           ],
//         ),
//
//
//      ),
//    );
//  }
//
// }

// class HijriDateView extends GetView<SettingController> {
//   @override
//   Widget build(BuildContext context) {
//     // Show dialog on page load
//     Future.delayed(Duration.zero, () {
//       Dialogs.showCustomDialog(
//         context: context,
//         content: GetBuilder<HijriController>(
//           builder: (hijriController) {
//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: hijriController.hijriDateAdjustment.length,
//               itemBuilder: (context, index) {
//                 var day = hijriController.hijriDateAdjustment[index];
//                 return Obx(() => ListTile(
//                   title: Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: hijriController.selectedId.value == day['id']
//                           ? AppColor.color
//                           : Colors.white54,
//                     ),
//                     child: Center(
//                       child: Text(
//                         day['name'],
//                         style: TextStyle(
//                           fontWeight: hijriController.selectedId.value == day['id']
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                           color: hijriController.selectedId.value == day['id']
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                   onTap: () {
//                     hijriController.updateSelectedId(day['id']);
//                     hijriController.registerUser();
//                     hijriController.selectItem(day['id']);
//                   },
//                 ));
//               },
//             );
//           },
//         ),
//       );
//     });
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           title: Text('Hijri Date Adjustment', style: MyTextTheme.mediumBCD),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1.0),
//             child: Divider(
//               height: 1.5,
//               color: AppColor.packageGray,
//             ),
//           ),
//           leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: const Icon(Icons.arrow_back_ios_new, size: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
