import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Notification/notificationController.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../../Routes/approutes.dart';
import 'AddFriendController.dart';
import 'AddFriendDataModal.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class AddFriendView extends GetView<AddFriendController> {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.put(NotificationController());
    final DashBoardController dashBoardController = Get.find<DashBoardController>();
    final TextEditingController searchController = TextEditingController();

    String capitalizeFirstLetter(String name) {
      if (name.isEmpty) return name;
      return name[0].toUpperCase() + name.substring(1).toLowerCase();
    }
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Invite friends', style: MyTextTheme.mediumBCD),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.inviteRoute);
              },
              child: Text("Invite", style: MyTextTheme.mustardN),
            ),
          ],
        ),
        body: GetBuilder(
          init: controller,
          builder: (_) {
            List<RegisteredUserDataModal> filteredUsers = controller.getRegisteredUserList
                .where((user) {
                  // Check if the search query matches the name or phone number (convert to lowercase for case-insensitivity)
                  final searchQuery = controller.searchQuery.toLowerCase();
                  final nameMatch = user.name?.toLowerCase().contains(searchQuery) ?? false;
                  final phoneMatch = user.mobileNo?.contains(searchQuery) ?? false;
                  return nameMatch || phoneMatch;
                })
                .toList();

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        controller.updateSearchQuery(value);
                      },
                      cursorColor: AppColor.circleIndicator,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Username..",
                        hintStyle: MyTextTheme.mediumCustomGCN,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        // suffixIcon: IconButton(
                        //   icon: const Icon(Icons.cancel, color: Colors.grey),
                        //   onPressed: () {
                        //     searchController.clear();
                        //     controller.updateSearchQuery("");
                        //   },
                        // ),
                        suffixIcon:
                          // Show the cancel icon only when there is text in the search bar
                        controller.searchQuery.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.grey,weight: 1,),
                            onPressed: () {
                              searchController.clear();
                              controller.updateSearchQuery('');
                              controller.update();
                            },
                          )
                              : const SizedBox.shrink()


                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Column(
                  //   children: [
                  //     Visibility(
                  //       visible: controller.getFriendRequestList.isNotEmpty,
                  //       child: Column(
                  //         children: [
                  //           // Header Row with "REQUESTS" and optional "SEE ALL"
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "REQUESTS",
                  //                 style: MyTextTheme.greyNormal
                  //               ),
                  //               // Show "SEE ALL" only if requests are more than 2
                  //
                  //               Visibility(
                  //                 visible: controller.getFriendRequestList.length > 2,
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     Get.to(() => SeeAll(),
                  //                       transition: Transition.rightToLeft,
                  //                       duration: Duration(milliseconds: 500),
                  //                       curve: Curves.ease,);
                  //                   },
                  //                   child: Text(
                  //                     "SEE ALL",
                  //                     style: MyTextTheme.greyNormal
                  //
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(height: 5,),
                  //           // Show ListView if request count <= 2, otherwise show only first 2 in this list
                  //           ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount: controller.getFriendRequestList.length <= 2
                  //                 ? controller.getFriendRequestList.length
                  //                 : 2, // Show only first 2 if there are more than 2 requests
                  //             itemBuilder: (context, index) {
                  //               FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
                  //
                  //               return Padding(
                  //                 padding: const EdgeInsets.all(8.0),
                  //                 child: Row(
                  //                   children: [
                  //                     // Profile Picture
                  //                     Container(
                  //                       width: 35,
                  //                       height: 40,
                  //                       decoration: BoxDecoration(
                  //                         shape: BoxShape.circle,
                  //                         image: friendRequestData.picture != null && friendRequestData.picture!.isNotEmpty
                  //                             ? DecorationImage(
                  //                           image: NetworkImage("http://182.156.200.177:8011${friendRequestData.picture}"),
                  //                           fit: BoxFit.cover,
                  //                         )
                  //                             : null,
                  //                         color: friendRequestData.picture == null || friendRequestData.picture!.isEmpty
                  //                             ? AppColor.circleIndicator
                  //                             : null,
                  //                       ),
                  //                       child: friendRequestData.picture == null || friendRequestData.picture!.isEmpty
                  //                           ? const Icon(Icons.person, size: 20, color: Colors.white)
                  //                           : null,
                  //                     ),
                  //
                  //                     // User Details
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.only(left: 12.0, top: 12),
                  //                         child: Column(
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               friendRequestData.name.toString(),
                  //                               style: MyTextTheme.mediumGCB.copyWith(
                  //                                 fontSize: 16,
                  //                                 color: Colors.black,
                  //                                 fontWeight: FontWeight.bold,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     // Accept and Decline Buttons
                  //                     Row(
                  //                       children: [
                  //                         InkWell(
                  //                           onTap: () async {
                  //                             await controller.acceptFriendRequest(friendRequestData);
                  //                             await notificationController.readNotificationMessage(notificationController.notifications[index]['id'].toString());
                  //                             // peerController.friendshipList.toString();
                  //                             await  dashBoardController.pending.value.toString();
                  //                           },
                  //                           child: Container(
                  //                             height: MediaQuery.of(context).size.height * 0.04,
                  //                             width: MediaQuery.of(context).size.width * 0.2,
                  //                             decoration: BoxDecoration(
                  //                               border: Border.all(color: AppColor.white),
                  //                               borderRadius: BorderRadius.circular(10),
                  //                               color: AppColor.circleIndicator,
                  //                             ),
                  //                             child: const Center(
                  //                               child: Text("Accept", style: TextStyle(color: Colors.white)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         const SizedBox(width: 5),
                  //                         InkWell(
                  //                           onTap: () async {
                  //                             await controller.declineRequest(friendRequestData);
                  //                             controller.friendRequestList.removeAt(index);
                  //                             controller.update();
                  //                           },
                  //                           child: Container(
                  //                             height: MediaQuery.of(context).size.height * 0.04,
                  //                             width: MediaQuery.of(context).size.width * 0.2,
                  //                             decoration: BoxDecoration(
                  //                               border: Border.all(color: AppColor.white),
                  //                               borderRadius: BorderRadius.circular(10),
                  //                               color: AppColor.greyColor,
                  //                             ),
                  //                             child: const Center(
                  //                               child: Text("Decline", style: TextStyle(color: Colors.white)),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ],
                  //                 ),
                  //               );
                  //
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SUGGESTIONS", style: MyTextTheme.greyNormal),
                    ],
                  ),

            if (filteredUsers.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          "No Suggestions.",
                          style: MyTextTheme.mediumGCB
                        ),
                      ),
                    ),
                Expanded(
                    child:
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          RegisteredUserDataModal registeredData = filteredUsers[index];
                          log("controller.invitedFriendList ${controller.invitedFriendList}");
                          var matchedRequest = controller.invitedFriendList.firstWhere((request) => request['receiver']['id'].toString() == registeredData.userId.toString(),
                            orElse: () => null,     );
                          print("matchedRequest $matchedRequest");
                          print("registeredData.userId ${registeredData.userId}");
                          print("registeredData.userId ${registeredData.name}");
                          print("registeredData.userId ${registeredData.mobileNo}");
                          print("Item${registeredData.picture}");
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5,8,5,8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: registeredData.picture != null && registeredData.picture!.isNotEmpty
                                            ? DecorationImage(
                                          image: NetworkImage("http://182.156.200.177:8011${registeredData.picture}"),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                        color: registeredData.picture == null || registeredData.picture!.isEmpty
                                            ? AppColor.circleIndicator
                                            : null,
                                      ),
                                      child: registeredData.picture == null || registeredData.picture!.isEmpty
                                          ? const Icon(Icons.person, size: 20, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          capitalizeFirstLetter(registeredData.name.toString()),
                                          style: MyTextTheme.mediumGCB.copyWith(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // SizedBox(height: 20,),
                                        Text(
                                            registeredData.username.toString(),
                                          style: MyTextTheme.smallGCB
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                  InkWell(
                                    onTap: () async {
                                      if(matchedRequest==null){
                                        await controller.sendFriendRequest(registeredData);
                                        controller.checkInviteStatus(UserData().getUserData!.id.toString());

                                      }
                                    },
                                    child:matchedRequest==null?
                                    Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.circleIndicator,
                                      ),
                                      child:  const Center(
                                        child: Text("Request", style: TextStyle(color: Colors.white)),
                                      ),
                                    )
                                        :
                                    Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.white),
                                        borderRadius: BorderRadius.circular(10),
                                        color:matchedRequest['status_display']=="Accepted"? Colors.green:AppColor.greyColor,
                                      ),
                                      child:  Center(
                                        child: Text(matchedRequest['status_display'], style: const TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ),

                              ]
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
