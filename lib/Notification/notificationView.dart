
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Drawer/drawerController.dart';
import '../PeerCircle/AddFriends/AddFriendDataModal.dart';
import '../Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'notificationController.dart';

class NotificationView extends  GetView<NotificationController> {

  @override
  Widget build(BuildContext context,) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();
    NotificationDataModal notificationData = NotificationDataModal(
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Notifications',style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: customDrawerController.isDarkMode == true? AppColor.scaffBg:AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Transform.scale(
            scale:
            MediaQuery.of(context).size.width <360 ? 0.6: 0.7,
            child:   CircleAvatar(
                radius: 12,
                backgroundColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                child: const Icon(Icons.arrow_back_ios_new,size: 20,)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.settingRoute);
            },
            child:SvgPicture.asset(
              "assets/set.svg",height: 25,color:Theme.of(context).iconTheme.color ,
            ),
          ),
        ],
      ),
      body:
      Obx(() {
      // Check if all categories are empty
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      bool isAllEmpty = controller.todayNotifications.isEmpty &&
          controller.yesterdayNotifications.isEmpty &&
          controller.last7DaysNotifications.isEmpty;

      return isAllEmpty
          ?  Column(
        children: [
          const SizedBox(height: 100,),
          Image.asset("assets/notifi.gif",),
          Text("No notifications yet",style: MyTextTheme.B.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color ),),
          Text("Your notification will appear here\n once you received them.",
            style: MyTextTheme.mediumBCb.copyWith(color: Theme.of(context).textTheme.titleSmall?.color ),)
        ],
      )
          : ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          buildCategory('Today', controller.todayNotifications,context),
          buildCategory('Yesterday', controller.yesterdayNotifications,context),
          buildCategory('Last 7 Days', controller.last7DaysNotifications,context)
        ],
      );
      }),
    );
  }
  Widget buildCategory(String title, List<dynamic> notifications,context) {
    if (notifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title of the category
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            title,
            style: MyTextTheme.mg.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color ),
          ),
        ),

        // List of notifications
        GetBuilder<NotificationController>(
            builder: (controller){
              return     ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  var notificationDate = DateTime.parse(notification['created_at']);
                  NotificationDataModal notificationData = NotificationDataModal(
                    userId: notification['request_id']?.toString(),
                  );
                  // Notification tile
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundImage: notification['sender_image'] != null &&
                                notification['sender_image'].isNotEmpty
                                ? NetworkImage(
                              controller.buildFullImageUrl(notification['sender_image']),
                            )
                                : null,
                            backgroundColor: notification['sender_image'] == null ||
                                notification['sender_image'].isEmpty
                                ? AppColor.color
                                : null,
                            child: notification['sender_image'] == null ||
                                notification['sender_image'].isEmpty
                                ? const Icon(Icons.person, size: 20, color: Colors.white)
                                : null,
                          ),
                          title: Text(
                            notification['message'],
                            style: MyTextTheme.smallBCn.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color ),
                          ),
                          subtitle: Text(
                            _timeAgo(notificationDate),
                            style:MyTextTheme.smallBCn.copyWith(color: Theme.of(context).textTheme.titleSmall?.color ),
                          ),
                        ),

                        Visibility(
                          visible: notification['type'] == 'friend_request',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await controller.acceptFriendRequest(notificationData);
                                    // Update the type and refresh UI
                                    notification['type'] = 'friend_request_acc';
                                    controller.update();
                                    await controller.readNotificationMessage(controller.notifications[index]['id'].toString());
                                    print("sssssssssssssss "+controller.notifications[index]['id'].toString());
                                    print('Friend request accepted and buttons hidden successfully.');
                                  } catch (e) {
                                    print('Error: $e');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.color,
                                  minimumSize: const Size(70, 30),
                                ),
                                child: const Text(
                                  'Accept',
                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                ),
                              ),

                              const SizedBox(width: 8),
                               ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            await controller.declineRequest(notificationData);
                                            // Update the type and refresh UI
                                            notification['type'] = 'friend_request_declined';
                                            controller.update();
                                            await controller.readNotificationMessage(controller.notifications[index]['id'].toString());
                                            print("sssssssssssssss "+controller.notifications[index]['id'].toString());
                                            print('Friend request declined and buttons hidden successfully.');
                                          } catch (e) {
                                            print('Error: $e');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.greyColor,
                                          minimumSize: const Size(70, 30),
                                        ),
                                        child: const Text(
                                          'Decline',
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                   ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            })
        // GetBuilder<NotificationController>(
        //   builder: (controller) {
        //     return ListView.builder(
        //       physics: const NeverScrollableScrollPhysics(),
        //       shrinkWrap: true,
        //       itemCount: controller.notifications.length,
        //       itemBuilder: (context, index) {
        //         var notification = controller.notifications[index];
        //         var notificationDate = DateTime.parse(notification['created_at']);
        //         NotificationDataModal notificationData = NotificationDataModal(
        //           userId: notification['request_id']?.toString(),
        //           // Add other properties as needed
        //         );
        //
        //         // Notification tile
        //         return Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        //           child: Column(
        //             children: [
        //               ListTile(
        //                 contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        //                 leading: CircleAvatar(
        //                   radius: 22,
        //                   backgroundImage: notification['sender_image'] != null &&
        //                       notification['sender_image'].isNotEmpty
        //                       ? NetworkImage(
        //                     controller.buildFullImageUrl(notification['sender_image']),
        //                   )
        //                       : null,
        //                   backgroundColor: notification['sender_image'] == null ||
        //                       notification['sender_image'].isEmpty
        //                       ? AppColor.color
        //                       : null,
        //                   child: notification['sender_image'] == null ||
        //                       notification['sender_image'].isEmpty
        //                       ? const Icon(Icons.person, size: 20, color: Colors.white)
        //                       : null,
        //                 ),
        //                 title: Text(
        //                   notification['message'],
        //                   style: MyTextTheme.smallBCn,
        //                 ),
        //                 subtitle: Text(
        //                   _timeAgo(notificationDate),
        //                   style: const TextStyle(color: Colors.grey, fontSize: 12),
        //                 ),
        //               ),
        //
        //               // Action buttons for friend requests
        //               Visibility(
        //                 visible: notification['type'] == 'friend_request',
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     ElevatedButton(
        //                       onPressed: () async {
        //                         try {
        //                           await controller.acceptFriendRequest(notificationData);
        //                           // Update the type and refresh UI
        //                           notification['type'] = 'friend_request_acc';
        //                            controller.update();
        //                           await controller.readNotificationMessage(controller.notifications[index]['id'].toString());
        //                           print("sssssssssssssss "+controller.notifications[index]['id'].toString());
        //                           print('Friend request accepted and buttons hidden successfully.');
        //                         } catch (e) {
        //                           print('Error: $e');
        //                         }
        //                       },
        //                       style: ElevatedButton.styleFrom(
        //                         backgroundColor: AppColor.color,
        //                         minimumSize: const Size(70, 30),
        //                       ),
        //                       child: const Text(
        //                         'Accept',
        //                         style: TextStyle(fontSize: 12, color: Colors.white),
        //                       ),
        //                     ),
        //                     const SizedBox(width: 8),
        //                     ElevatedButton(
        //                       onPressed: () async {
        //                         try {
        //                           await controller.declineRequest(notificationData);
        //                           // Update the type and refresh UI
        //                           notification['type'] = 'friend_request_declined';
        //                           controller.update();
        //                           await controller.readNotificationMessage(controller.notifications[index]['id'].toString());
        //                           print("sssssssssssssss "+controller.notifications[index]['id'].toString());
        //                           print('Friend request declined and buttons hidden successfully.');
        //                         } catch (e) {
        //                           print('Error: $e');
        //                         }
        //                       },
        //                       style: ElevatedButton.styleFrom(
        //                         backgroundColor: AppColor.greyColor,
        //                         minimumSize: const Size(70, 30),
        //                       ),
        //                       child: const Text(
        //                         'Decline',
        //                         style: TextStyle(fontSize: 12, color: Colors.white),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      ],
    );
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
