// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:namaz_reminders/Setting/Privacy&Security/PrivacyController.dart';
// import 'package:namaz_reminders/Setting/SettingController.dart';
// import '../../Widget/appColor.dart';
// import '../../Widget/text_theme.dart';
//
// class PrivacyView extends GetView<SettingController>{
//   @override
//   Widget build(BuildContext context) {
//     final PrivacyController privacyController = Get.put(PrivacyController());
//
//     // TODO: implement build
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             centerTitle: true,
//             title: Text('Privacy & Security', style: MyTextTheme.mediumBCD),
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(1.0),
//               child: Divider(
//                 height: 1.5,
//                 color: AppColor.packageGray,
//               ),
//             ),
//             leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: const Icon(Icons.arrow_back_ios_new,size: 20,),
//             ),
//           ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Obx(() => SwitchListTile(
//                 activeTrackColor: AppColor.color,
//                 title: Text('Location',style: MyTextTheme.medium2,),
//                 subtitle: Text('Allow location access to provide accurate data according to your location.',style: MyTextTheme.smallGCN,),
//                 value: privacyController.location.value,
//                 onChanged: (value) => privacyController.toggleLocationAccess(value)
//               )
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }}
//
//
