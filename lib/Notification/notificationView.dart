
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../PeerCircle/AddFriends/AddFriendDataModal.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'NotificationSetting/notificationSettingView.dart';
import 'notificationController.dart';

class NotificationView extends  GetView<NotificationController> {

  @override
  Widget build(BuildContext context,) {
    NotificationDataModal notificationData = NotificationDataModal(
      // Add other properties as needed
    );
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
          child: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => NotificationSetting (),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,);

            },
            child:SvgPicture.asset(
              "assets/set.svg",height: 25,color: AppColor.greyDark,
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
          Text("No notifications yet",style: MyTextTheme.B,),
          Text("Your notification will appear here\n once you received them.",style: MyTextTheme.mediumBCb,)
        ],
      )
          : ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          buildCategory('Today', controller.todayNotifications),
          buildCategory('Yesterday', controller.yesterdayNotifications),
          buildCategory('Last 7 Days', controller.last7DaysNotifications)
        ],
      );
              }),
    );
  }
  Widget buildCategory(String title, List<dynamic> notifications) {
    if (notifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title of the category
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            title,
            style: MyTextTheme.mg,
          ),
        ),

        // List of notifications
        // ListView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: notifications.length,
        //   itemBuilder: (context, index) {
        //     var notification = notifications[index];
        //     var notificationDate = DateTime.parse(notification['created_at']);
        //     NotificationDataModal notificationData = NotificationDataModal(
        //       userId: notification['request_id']?.toString(),
        //       // Add other properties as needed
        //     );
        //     // Notification tile
        //     return Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        //       child: Column(
        //         children: [
        //           ListTile(
        //             contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        //             leading: CircleAvatar(
        //               radius: 22,
        //               backgroundImage: notification['sender_image'] != null &&
        //                   notification['sender_image'].isNotEmpty
        //                   ? NetworkImage(
        //                 controller.buildFullImageUrl(notification['sender_image']),
        //               )
        //                   : null,
        //               backgroundColor: notification['sender_image'] == null ||
        //                   notification['sender_image'].isEmpty
        //                   ? AppColor.circleIndicator
        //                   : null,
        //               child: notification['sender_image'] == null ||
        //                   notification['sender_image'].isEmpty
        //                   ? const Icon(Icons.person, size: 20, color: Colors.white)
        //                   : null,
        //             ),
        //             title: Text(
        //               notification['message'],
        //               style: MyTextTheme.smallBCn,
        //             ),
        //             subtitle: Text(
        //               _timeAgo(notificationDate),
        //               style: const TextStyle(color: Colors.grey, fontSize: 12),
        //             ),
        //           ),
        //
        //           // Action buttons for friend requests
        //          // if (notification['type'] == 'friend_request')
        //          //    Visibility(
        //          //      visible:  notification['type']=='friend_request_acc',
        //          //      child: Row(
        //          //        mainAxisAlignment: MainAxisAlignment.center,
        //          //        children: [
        //          //          ElevatedButton(
        //          //            onPressed: () async {
        //          //              try {
        //          //                // Accept the friend request
        //          //                await controller.acceptFriendRequest(notificationData);
        //          //                await controller.readNotificationMessage(notificationData) ;
        //          //             //   await controller.removeNotification(notificationData);
        //          //
        //          //                print('Friend request accepted and notification removed successfully.');
        //          //              } catch (e) {
        //          //                print('Error: $e');
        //          //              }
        //          //            },
        //          //            style: ElevatedButton.styleFrom(
        //          //              backgroundColor: AppColor.circleIndicator,
        //          //              minimumSize: const Size(70, 30),
        //          //            ),
        //          //            child: const Text(
        //          //              'Accept',
        //          //              style: TextStyle(fontSize: 12, color: Colors.white),
        //          //            ),
        //          //          ),
        //          //
        //          //          const SizedBox(width: 8),
        //          //          ElevatedButton(
        //          //            onPressed: () async {
        //          //              await controller.declineRequest(notificationData);
        //          //              controller.update();
        //          //            },
        //          //            style: ElevatedButton.styleFrom(
        //          //              backgroundColor: AppColor.circleIndicator,
        //          //              minimumSize: const Size(70, 30),
        //          //            ),
        //          //            child: const Text('Decline', style: TextStyle(fontSize: 12, color: Colors.white)),
        //          //          ),
        //          //        ],
        //          //      ),
        //          //    ),
        //           Visibility(
        //             visible: notification['type'] == 'friend_request',
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     try {
        //                       await controller.acceptFriendRequest(notificationData);
        //                       notification['type'] = 'friend_request_acc';
        //
        //
        //                       print('Friend request accepted and buttons hidden successfully.');
        //                     } catch (e) {
        //                       print('Error: $e');
        //                     }
        //                   },
        //                   style: ElevatedButton.styleFrom(
        //                     backgroundColor: AppColor.circleIndicator,
        //                     minimumSize: const Size(70, 30),
        //                   ),
        //                   child: const Text(
        //                     'Accept',
        //                     style: TextStyle(fontSize: 12, color: Colors.white),
        //                   ),
        //                 ),
        //                 const SizedBox(width: 8),
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     try {
        //                       await controller.declineRequest(notificationData);
        //
        //                       notification['type'] = 'friend_request_declined';
        //
        //                       print('Friend request declined and buttons hidden successfully.');
        //                     } catch (e) {
        //                       print('Error: $e');
        //                     }
        //                   },
        //                   style: ElevatedButton.styleFrom(
        //                     backgroundColor: AppColor.circleIndicator,
        //                     minimumSize: const Size(70, 30),
        //                   ),
        //                   child: const Text(
        //                     'Decline',
        //                     style: TextStyle(fontSize: 12, color: Colors.white),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        GetBuilder<NotificationController>(
          builder: (controller) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                var notification = controller.notifications[index];
                var notificationDate = DateTime.parse(notification['created_at']);
                NotificationDataModal notificationData = NotificationDataModal(
                  userId: notification['request_id']?.toString(),
                  // Add other properties as needed
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
                              ? AppColor.circleIndicator
                              : null,
                          child: notification['sender_image'] == null ||
                              notification['sender_image'].isEmpty
                              ? const Icon(Icons.person, size: 20, color: Colors.white)
                              : null,
                        ),
                        title: Text(
                          notification['message'],
                          style: MyTextTheme.smallBCn,
                        ),
                        subtitle: Text(
                          _timeAgo(notificationDate),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),

                      // Action buttons for friend requests
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
                                backgroundColor: AppColor.circleIndicator,
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
                                backgroundColor: AppColor.circleIndicator,
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
          },
        ),


      ],
    );
  }

  // Widget _buildActionButtons(Map<String, dynamic> notification) {
  //   // Debug the notification object
  //   print("Notification Data: $notification");
  //
  //   if (notification['type'] == 'friend_request') {
  //     String requestId = notification['sender_id'].toString();
  //     String userId = controller.userData.getUserData?.id.toString() ?? "Unknown";
  //
  //     // Debug extracted IDs
  //     print("Accepting friend request with ID: $requestId");
  //     print("User ID: $userId");
  //
  //     if (requestId.isEmpty || userId == "Unknown") {
  //       print("Invalid requestId or userId.");
  //       return const SizedBox.shrink();
  //     }
  //
  //     return Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         ElevatedButton(
  //           onPressed: () async {
  //             print("Accept button pressed");
  //             await controller.acceptFriendRequest(requestId);
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColor.circleIndicator,
  //             minimumSize: const Size(70, 30),
  //           ),
  //           child: const Text('Accept', style: TextStyle(fontSize: 12, color: Colors.white)),
  //         ),
  //         const SizedBox(width: 8),
  //         ElevatedButton(
  //           onPressed: () async {
  //             print("Decline button pressed");
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColor.circleIndicator,
  //             minimumSize: const Size(70, 30),
  //           ),
  //           child: const Text('Decline', style: TextStyle(fontSize: 12, color: Colors.white)),
  //         ),
  //       ],
  //     );
  //   }
  //   return const SizedBox.shrink();
  // }



  String _timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return DateFormat('dd MMM').format(date);
  }
}
//////////////////////////////
