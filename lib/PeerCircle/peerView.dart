import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Notification/notificationController.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendController.dart';
import 'package:namaz_reminders/PeerCircle/peerController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import '../DashBoard/dashboardController.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'AddFriends/AddFriendDataModal.dart';
import 'AddFriends/SeeAll.dart';

class PeerView extends GetView<PeerController> {
  const PeerView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final PeerController peerController = Get.put(PeerController());
    final AddFriendController addFriendController = Get.put(AddFriendController());
    final NotificationController notificationController = Get.put(NotificationController());

    final DashBoardController dashBoardController = Get.find();
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Peer Circle', style: MyTextTheme.mediumBCD),
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
              // Get.toNamed(AppRoutes.dashboardRoute);
            },
            child: const Icon(Icons.arrow_back_ios_new,size: 20,),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.addfriendRoute);
              },
              child: Text("+ Add", style: MyTextTheme.mustard),
            ),
          ],
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                   child: TextField(
                     controller: searchController,
                     onChanged: (value) {
                       peerController.setSearchText(value);
                     },
                     cursorColor: AppColor.circleIndicator,
                     decoration: InputDecoration(
                       prefixIcon:  Icon(Icons.search,),
                       hintText: "Search Username..",
                       hintStyle: MyTextTheme.mediumCustomGCN,
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: const BorderSide(color: Colors.black),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: const BorderSide(color: Colors.grey, width: 1),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: const BorderSide(color: Colors.grey, width: 1),
                       ),
                       suffixIcon: IconButton(
                         icon: const Icon(Icons.cancel, color: Colors.grey),
                         onPressed: () {
                           searchController.clear();
                           peerController.setSearchText('');
                         },
                       ),
                     ),
                     style: const TextStyle(color: Colors.grey),
                   ),

                // child: TextField(
                //   controller: searchController,
                //   onChanged: (value) {
                //     // Update the search text in the controller as the user types
                //     peerController.setSearchText(value);
                //   },
                //   cursorColor: AppColor.circleIndicator,
                //   decoration: InputDecoration(
                //     prefixIcon: const Icon(Icons.search),
                //     hintText: "Search Username..",
                //     hintStyle: MyTextTheme.mediumCustomGCN,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(color: Colors.black),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(color: Colors.grey, width: 1),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10),
                //       borderSide: const BorderSide(color: Colors.grey, width: 1),
                //     ),
                //   ),
                //   style: const TextStyle(color: Colors.grey),
                // ),

              ),
              const SizedBox(height: 15),
              GetBuilder(
                init: addFriendController,
                builder: (controller) {
                  return Visibility(
                    visible: controller.getFriendRequestList.isNotEmpty,
                    child: Column(
                      children: [
                        // Header Row with "REQUESTS" and optional "SEE ALL"
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "REQUESTS",
                              style: MyTextTheme.greyNormal,
                            ),
                            // Show "SEE ALL" only if requests are more than 2
                            Visibility(
                              visible: controller.getFriendRequestList.length > 2,
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                        () => SeeAll(),
                                    transition: Transition.rightToLeft,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Text(
                                  "SEE ALL",
                                  style: MyTextTheme.greyNormal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Show ListView if request count <= 2, otherwise show only first 2 in this list
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.getFriendRequestList.length <= 2
                              ? controller.getFriendRequestList.length
                              : 2, // Show only first 2 if there are more than 2 requests
                          itemBuilder: (context, index) {
                            FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];

                            return Row(
                              children: [
                                // Profile Picture
                                Container(
                                  width: 35,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: friendRequestData.picture != null &&
                                        friendRequestData.picture!.isNotEmpty
                                        ? DecorationImage(
                                      image: NetworkImage(
                                          "http://182.156.200.177:8011${friendRequestData.picture}"),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                    color: friendRequestData.picture == null ||
                                        friendRequestData.picture!.isEmpty
                                        ? AppColor.circleIndicator
                                        : null,
                                  ),
                                  child: friendRequestData.picture == null ||
                                      friendRequestData.picture!.isEmpty
                                      ? const Icon(Icons.person,
                                      size: 20, color: Colors.white)
                                      : null,
                                ),

                                // User Details
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          friendRequestData.name.toString(),
                                          style: MyTextTheme.mediumGCB.copyWith(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Accept and Decline Buttons
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await controller.acceptFriendRequest(
                                            friendRequestData);
                                        await notificationController
                                            .readNotificationMessage(
                                            notificationController.notifications[index]
                                            ['id']
                                                .toString());
                                        await dashBoardController.pending.value
                                            .toString();


                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.04,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.white),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.circleIndicator,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      onTap: () async {
                                        await controller.declineRequest(friendRequestData);
                                        await notificationController
                                            .readNotificationMessage(
                                            notificationController.notifications[index]
                                            ['id']
                                                .toString());
                                        controller.friendRequestList.removeAt(index);
                                        controller.update();
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.04,
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppColor.white),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColor.greyColor,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Decline",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: 15,),


              // Expanded(
              //   child: GetBuilder<PeerController>(
              //       builder: (_) {
              //         if (peerController.isLoading.value) {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //
              //         if (peerController.filteredFriendsList.isEmpty) {
              //           return Center(child: Text('No friends found'));
              //         }
              //
              //         return ListView.builder(
              //           itemCount: peerController.filteredFriendsList.length,
              //           itemBuilder: (context, index) {
              //             Friendship friend = peerController
              //                 .filteredFriendsList[index];
              //             return Column(
              //               children: [
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Row(
              //                       children: [
              //
              //                         Container(
              //                           width: 35,
              //                           height: 40,
              //                           decoration: BoxDecoration(
              //                             shape: BoxShape.circle,
              //                             image: friend.user2.picture != null &&
              //                                 friend.user2.picture!.isNotEmpty
              //                                 ? DecorationImage(
              //                               image: NetworkImage(
              //                                   "http://182.156.200.177:8011${friend
              //                                       .user2.picture}"),
              //                               fit: BoxFit.cover,
              //                             )
              //                                 : null,
              //                             color: friend.user2.picture == null ||
              //                                 friend.user2.picture!.isEmpty
              //                                 ? AppColor.circleIndicator
              //                                 : null,
              //                           ),
              //                           child: friend.user2.picture == null ||
              //                               friend.user2.picture!.isEmpty
              //                               ? const Icon(Icons.person, size: 20,
              //                               color: Colors.white)
              //                               : null,
              //                         ),
              //
              //                         Padding(
              //                           padding: const EdgeInsets.only(
              //                               left: 12.0, top: 12),
              //                           child: Column(
              //                             crossAxisAlignment: CrossAxisAlignment
              //                                 .start,
              //                             children: [
              //                               Text(
              //                                 friend.user2.name.toString(),
              //                                 style: MyTextTheme.mediumGCB
              //                                     .copyWith(
              //                                   fontSize: 14,
              //                                   color: Colors.black,
              //                                   fontWeight: FontWeight.bold,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 friend.user2.username.toString(),
              //                                 style: MyTextTheme.smallGCB,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     // Trailing TextButton for Remove
              //                     TextButton(
              //                       onPressed: () {
              //                         showDialog(
              //                           context: context,
              //                           builder: (BuildContext context) {
              //                             return Dialog(
              //                               backgroundColor: Colors.black,
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: [
              //                                   const SizedBox(height: 20),
              //                                   Image.asset(
              //                                     "assets/container.png",
              //                                     width: 40,
              //                                     height: 50,
              //                                   ),
              //                                   const SizedBox(height: 16),
              //                                   Text("ARE YOU SURE?",
              //                                       style: MyTextTheme.mustard),
              //                                   const SizedBox(height: 16),
              //                                   Padding(
              //                                     padding: const EdgeInsets.all(
              //                                         8.0),
              //                                     child: Row(
              //                                       mainAxisAlignment: MainAxisAlignment
              //                                           .center,
              //                                       children: [
              //                                         Container(
              //                                           decoration: BoxDecoration(
              //                                             color: AppColor
              //                                                 .circleIndicator,
              //                                             borderRadius: BorderRadius
              //                                                 .circular(10),
              //                                           ),
              //                                           child: TextButton(
              //                                             onPressed: () {
              //                                               Navigator.of(context)
              //                                                   .pop();
              //                                             },
              //                                             child: const Text(
              //                                               'No, Go Back',
              //                                               style: TextStyle(
              //                                                   color: Colors
              //                                                       .white),
              //                                             ),
              //                                             style: TextButton
              //                                                 .styleFrom(
              //                                               padding: const EdgeInsets
              //                                                   .symmetric(
              //                                                   horizontal: 10,
              //                                                   vertical: 5),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                         const SizedBox(width: 16),
              //                                         Container(
              //                                           decoration: BoxDecoration(
              //                                             color: Colors.grey,
              //                                             borderRadius: BorderRadius
              //                                                 .circular(10),
              //                                           ),
              //                                           child: TextButton(
              //                                             onPressed: () async {
              //                                               await peerController
              //                                                   .removeFriend(
              //                                                   friend.user2.id
              //                                                       .toString());
              //                                               peerController
              //                                                   .filteredFriendsList
              //                                                   .removeAt(index);
              //                                               peerController.update();
              //                                               Get.back();
              //                                             },
              //                                             child: const Text(
              //                                               'Yes, Remove',
              //                                               style: TextStyle(
              //                                                   color: Colors
              //                                                       .white),
              //                                             ),
              //                                             style: TextButton
              //                                                 .styleFrom(
              //                                               padding: const EdgeInsets
              //                                                   .symmetric(
              //                                                   horizontal: 10,
              //                                                   vertical: 5),
              //                                             ),
              //                                           ),
              //                                         ),
              //
              //
              //                                       ],
              //                                     ),
              //                                   ),
              //                                   const SizedBox(height: 20),
              //                                 ],
              //                               ),
              //                             );
              //                           },
              //                         );
              //                       },
              //                       child: Text('Remove', style: TextStyle(
              //                           color: AppColor.circleIndicator)),
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             );
              //           },
              //         );
              //
              //
              //       }),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "FRIENDS",
                      style: MyTextTheme.greyNormal,
                    ),

                    // Friend list below the title
                    Expanded(
                      child: GetBuilder<PeerController>(builder: (_) {
                        if (peerController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (peerController.filteredFriendsList.isEmpty) {
                          return Center(child: Text('No friends found'));
                        }

                        return ListView.builder(
                          itemCount: peerController.filteredFriendsList.length,
                          itemBuilder: (context, index) {
                            Friendship friend = peerController.filteredFriendsList[index];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: friend.user2.picture != null &&
                                                friend.user2.picture!.isNotEmpty
                                                ? DecorationImage(
                                              image: NetworkImage(
                                                "http://182.156.200.177:8011${friend.user2.picture}",
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                                : null,
                                            color: friend.user2.picture == null ||
                                                friend.user2.picture!.isEmpty
                                                ? AppColor.circleIndicator
                                                : null,
                                          ),
                                          child: friend.user2.picture == null ||
                                              friend.user2.picture!.isEmpty
                                              ? const Icon(Icons.person,
                                              size: 20, color: Colors.white)
                                              : null,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0, top: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                friend.user2.name.toString(),
                                                style: MyTextTheme.mediumGCB.copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                friend.user2.username.toString(),
                                                style: MyTextTheme.smallGCB,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              backgroundColor: Colors.black,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Image.asset(
                                                    "assets/container.png",
                                                    width: 40,
                                                    height: 50,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text("ARE YOU SURE?",
                                                      style: MyTextTheme.mustard),
                                                  const SizedBox(height: 16),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color:
                                                            AppColor.circleIndicator,
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text(
                                                              'No, Go Back',
                                                              style: TextStyle(
                                                                  color: Colors.white),
                                                            ),
                                                            style: TextButton.styleFrom(
                                                              padding:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 10,
                                                                  vertical: 5),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                          ),
                                                          child: TextButton(
                                                            onPressed: () async {
                                                              await peerController.removeFriend(
                                                                  friend.user2.id.toString());
                                                              peerController.filteredFriendsList
                                                                  .removeAt(index);
                                                              peerController.update();
                                                              Get.back();
                                                            },
                                                            child: const Text(
                                                              'Yes, Remove',
                                                              style: TextStyle(
                                                                  color: Colors.white),
                                                            ),
                                                            style: TextButton.styleFrom(
                                                              padding:
                                                              const EdgeInsets.symmetric(
                                                                  horizontal: 10,
                                                                  vertical: 5),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Remove',
                                          style: TextStyle(
                                              color: AppColor.circleIndicator)),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              )

            ],
          ),
        )
      ),
    );
  }
}

