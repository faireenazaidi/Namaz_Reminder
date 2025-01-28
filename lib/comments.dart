// GetBuilder<AddFriendController>(
// init: addFriendController,
// builder: (controller) {
// return Visibility(
// visible: controller.getFriendRequestList.isNotEmpty,
// child: Column(
// children: [
// // Header Row with "REQUESTS" and optional "SEE ALL"
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// "REQUESTS",
// style: MyTextTheme.greyNormal,
// ),
// // Show "SEE ALL" only if requests are more than 2
// Visibility(
// visible: controller.getFriendRequestList.length > 2,
// child: InkWell(
// onTap: () {
// Get.to(
// () => SeeAll(),
// transition: Transition.rightToLeft,
// duration: const Duration(milliseconds: 500),
// curve: Curves.ease,
// );
// },
// child: Text(
// "SEE ALL",
// style: MyTextTheme.greyNormal,
// ),
// ),
// ),
// ],
// ),
// const SizedBox(height: 5),
// // Show ListView if request count <= 2, otherwise show only first 2 in this list
// ListView.builder(
// shrinkWrap: true,
// itemCount: controller.getFriendRequestList.length <= 2
// ? controller.getFriendRequestList.length
//     : 2, // Show only first 2 if there are more than 2 requests
// itemBuilder: (context, index) {
// FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
//
// return Row(
// children: [
// // Profile Picture
// Container(
// width: 35,
// height: 40,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// image: friendRequestData.picture != null &&
// friendRequestData.picture!.isNotEmpty
// ? DecorationImage(
// image: NetworkImage(
// "http://182.156.200.177:8011${friendRequestData.picture}"),
// fit: BoxFit.cover,
// )
//     : null,
// color: friendRequestData.picture == null ||
// friendRequestData.picture!.isEmpty
// ? AppColor.color
//     : null,
// ),
// child: friendRequestData.picture == null ||
// friendRequestData.picture!.isEmpty
// ? const Icon(Icons.person,
// size: 20, color: Colors.white)
//     : null,
// ),
//
// // User Details
// Expanded(
// child: Padding(
// padding: const EdgeInsets.only(left: 12.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// friendRequestData.name.toString(),
// style: MyTextTheme.mediumGCB.copyWith(
// fontSize: 16,
// color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// ),
// ),
// // Accept and Decline Buttons
// Row(
// children: [
// InkWell(
// onTap: () async {
// await controller.acceptFriendRequest(
// friendRequestData);
// await notificationController
//     .readNotificationMessage(
// notificationController.notifications[index]
// ['id']
//     .toString());
// await dashBoardController.pending.value
//     .toString();
// },
// child: Container(
// height: MediaQuery.of(context).size.height * 0.04,
// width: MediaQuery.of(context).size.width * 0.2,
// decoration: BoxDecoration(
// border: Border.all(color: AppColor.white),
// borderRadius: BorderRadius.circular(10),
// color: AppColor.color,
// ),
// child: const Center(
// child: Text(
// "Accept",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
// const SizedBox(width: 5),
// InkWell(
// onTap: () async {
// await controller.declineRequest(friendRequestData);
// controller.friendRequestList.removeAt(index);
// controller.update();
// },
// child: Container(
// height: MediaQuery.of(context).size.height * 0.04,
// width: MediaQuery.of(context).size.width * 0.2,
// decoration: BoxDecoration(
// border: Border.all(color: AppColor.white),
// borderRadius: BorderRadius.circular(10),
// color: AppColor.greyColor,
// ),
// child: const Center(
// child: Text(
// "Decline",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
// ],
// ),
// ],
// );
// },
// ),
// ],
// ),
// );
// },
// ),

//
// child: TextField(
// controller: searchController,
// onChanged: (value) {
// // Update the search text in the controller as the user types
// peerController.setSearchText(value);
// },
// cursorColor: AppColor.color,
// decoration: InputDecoration(
// prefixIcon: const Icon(Icons.search),
// hintText: "Search Username..",
// hintStyle: MyTextTheme.mediumCustomGCN,
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: const BorderSide(color: Colors.black),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: const BorderSide(color: Colors.grey, width: 1),
// ),
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: const BorderSide(color: Colors.grey, width: 1),
// ),
// // Add the suffix icon for clearing the text
// suffixIcon: IconButton(
// icon: const Icon(Icons.cancel, color: Colors.grey),
// onPressed: () {
// // Clear the text field and update the controller
// searchController.clear();
// peerController.setSearchText(''); // Clear the search text in the controller
// },
// ),
// ),
// style: const TextStyle(color: Colors.grey),
// ),
//////////////////
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:namaz_reminders/Setting/HijriDate/hijriController.dart';
// import 'package:namaz_reminders/Setting/SettingController.dart';
// import '../../AppManager/dialogs.dart';
// import '../../DashBoard/dashboardController.dart';
// import '../../Widget/appColor.dart';
// import '../../Widget/text_theme.dart';
//
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
//         body:
//             Column(
//               children: [
//                 ElevatedButton(
//                     onPressed: (){
//                       Dialogs.showCustomDialog(
//                         context: context,
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min, // Use min size to fit content
//                           children: [
//                             Text(
//                               'This is a custom dialog',
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               'You can put any widget here.',
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Close the dialog
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('Close'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     child: Text("hloooo")
//                 )
//
//               ],
//             )
//
//
//
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../AppManager/dialogs.dart';
// import '../../Widget/appColor.dart';
// import '../../Widget/text_theme.dart';
// import '../SettingController.dart';
//
// class HijriDateView extends  GetView<SettingController>  {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text('Hijri Date Adjustment', style: MyTextTheme.mediumBCD),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1.0),
//           child: Divider(
//             height: 1.5,
//             color: AppColor.packageGray,
//           ),
//         ),
//         leading: InkWell(
//           onTap: () {
//             Get.back(
//               //     () => SettingView(),
//               // transition: Transition.rightToLeft,
//               // duration: Duration(milliseconds: 500),
//               // curve: Curves.ease,
//             );
//           },
//           child: const Icon(Icons.arrow_back_ios_new, size: 20),
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Dialogs.showCustomDialog(
//               context: context,
//               content: IncrementDecrementDialog(),
//             );
//           },
//           child: Text('Adjust Hijri Date'),
//         ),
//       ),
//     );
//   }
// }
//
// class IncrementDecrementDialog extends StatefulWidget {
//   @override
//   _IncrementDecrementDialogState createState() => _IncrementDecrementDialogState();
// }
//
// class _IncrementDecrementDialogState extends State<IncrementDecrementDialog> {
//   int _counter = 0;
//
//   void _increment() {
//     setState(() {
//       if (_counter < 2)
//         _counter++;
//     });
//   }
//
//   void _decrement() {
//     setState(() {
//       if (_counter > -2) {
//         _counter--;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min, // Use min size to fit content
//       children: [
//         Text(
//           'Adjust Hijri Date',
//           style: MyTextTheme.mustardN,
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: AppColor.color,
//                   borderRadius: BorderRadius.circular(15)
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.remove,color: Colors.white,),
//                 onPressed: _decrement,
//               ),
//             ),
//             SizedBox(width: 20),
//             Text(
//                 '$_counter',
//                 style: MyTextTheme.mediumWCB
//             ),
//             SizedBox(width: 20),
//             Container(
//               decoration: BoxDecoration(
//                   color: AppColor.color,
//                   borderRadius: BorderRadius.circular(15)
//               ),
//               child: IconButton(
//                 icon: Icon(Icons.add,color: Colors.white,),
//                 onPressed: _increment,
//
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         // ElevatedButton(
//         //   onPressed: () {
//         //     // Close the dialog
//         //     Navigator.of(context).pop();
//         //   },
//         //   child: Text('Close'),
//         // ),
//       ],
//     );
//   }
// }