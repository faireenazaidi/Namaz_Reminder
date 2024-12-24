// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:namaz_reminders/Notification/notificationController.dart';
// import '../DashBoard/dashboardView.dart';
// import '../Widget/appColor.dart';
// import '../Widget/text_theme.dart';
// import 'NotificationSetting/notificationSettingView.dart';
// import 'notificationDataModal.dart';
//
// class NotificationView extends GetView<NotificationController>{
//   @override
//   Widget build(BuildContext context) {
//     print('odddndn');
//     print( controller.notificationsLast7Days);
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           title: Text('Notifications', style: MyTextTheme.mediumBCD),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1.0),
//             child: Divider(
//               height: 1.0,
//               color: AppColor.packageGray,
//             ),
//           ),
//           leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Icon(Icons.arrow_back_ios_new,size: 20,),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.to(() => NotificationSetting (),
//                   transition: Transition.rightToLeft,
//                   duration: Duration(milliseconds: 500),
//                   curve: Curves.ease,);
//
//               },
//               child:SvgPicture.asset(
//                 "assets/set.svg",height: 25,color: AppColor.greyDark,
//               ),
//             ),
//           ],
//         ),
//         body: Obx(() {
//           return ListView(
//             children: [
//               buildNotificationSection('Today', controller.notificationsToday),
//               buildNotificationSection('Yesterday', controller.notificationsYesterday),
//               buildNotificationSection('Last 7 Days', controller.notificationsLast7Days),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//   Widget buildNotificationSection(String title, List<NotificationModel> notifications) {
//     return notifications.isEmpty
//         ? Container(
//     )
//         : Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: notifications.length,
//           itemBuilder: (context, index) {
//             final notification = notifications[index];
//             return ListTile(
//               title: Text(notification.title),
//               subtitle: Text(notification.time),
//               trailing: (title == "Today" && notification.title.contains("wants to add"))
//                   ? Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextButton(onPressed: () {}, child: Text('Decline')),
//                   TextButton(onPressed: () {}, child: Text('Accept')),
//                 ],
//               )
//                   : null,
//             );
//           },
//         ),
//       ],
//     );
//   }}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../PeerCircle/peerController.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'NotificationSetting/notificationSettingView.dart';
import 'notificationController.dart';

class NotificationView extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());
  final PeerController peerController = Get.put(PeerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Notifications', style: MyTextTheme.mediumBCD),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              height: 1.0,
              color: AppColor.packageGray,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.to(() => NotificationSetting (),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,);

              },
              child:SvgPicture.asset(
                "assets/set.svg",height: 25,color: AppColor.greyDark,
              ),
            ),
          ],
      ),
      body:Obx(() {
        // Check if all categories are empty
        bool isAllEmpty = controller.todayNotifications.isEmpty &&
            controller.yesterdayNotifications.isEmpty &&
            controller.last7DaysNotifications.isEmpty;
        return isAllEmpty
            ?  Column(
              children: [
                SizedBox(height: 100,),
                Image.asset("assets/notifi.gif",),
                Text("No notifications yet",style: MyTextTheme.B,),
                Text("Your notification will appear here\n once you received them.",style: MyTextTheme.mediumBCb,)
              ],
            )

            : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      children: [
            buildCategory('Today', controller.todayNotifications),
            buildCategory('Yesterday', controller.yesterdayNotifications),
            buildCategory('Last 7 Days', controller.last7DaysNotifications),
                      ],
                    );
      }),

    );
  }

  Widget buildCategory(String title, List<dynamic> notifications) {
    if (notifications.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            title,
            style: MyTextTheme.mg,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            var notificationDate = DateTime.parse(notification['created_at']);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: controller.userData.getUserData?.picture != null &&
                        controller.userData.getUserData!.picture.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(
                          "http://182.156.200.177:8011${controller.userData.getUserData!.picture}"),
                      fit: BoxFit.cover,
                    )
                        : null,
                    color: (controller.userData.getUserData?.picture == null ||
                        controller.userData.getUserData!.picture.isEmpty)
                        ? AppColor.circleIndicator
                        : null,
                  ),
                  child: (controller.userData.getUserData?.picture == null ||
                      controller.userData.getUserData!.picture.isEmpty)
                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                      : null,
                ),
                title: Text(
                  notification['message'],
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  _timeAgo(notificationDate),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                trailing: _buildActionButtons(notification),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> notification) {
    // Check if notification requires actions (e.g., Accept/Decline)
    if (notification['requires_action'] == true) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => print('Decline action'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(70, 30),
            ),
            child: Text('Decline', style: TextStyle(fontSize: 12)),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => print('Accept action'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(70, 30),
            ),
            child: Text('Accept', style: TextStyle(fontSize: 12)),
          ),
        ],
      );
    }
    return SizedBox.shrink();
  }
  String _timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return DateFormat('dd MMM').format(date);
  }
}
//////////////////////////////
