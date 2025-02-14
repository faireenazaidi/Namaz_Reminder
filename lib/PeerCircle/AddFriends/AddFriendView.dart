import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Notification/notificationController.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import '../../Drawer/drawerController.dart';
import '../../Routes/approutes.dart';
import 'AddFriendController.dart';
import 'AddFriendDataModal.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class AddFriendView extends GetView<AddFriendController> {
  const AddFriendView({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    String capitalizeFirstLetter(String name) {
      if (name.isEmpty) return name;
      return name[0].toUpperCase() + name.substring(1).toLowerCase();
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('Invite friends', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
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
              Get.toNamed(AppRoutes.inviteRoute);
            },
            child: Text("Invite", style: MyTextTheme.mustardN),
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          // List<RegisteredUserDataModal> filteredUsers = controller.getRegisteredUserList
          //     .where((user) {
          //       // Check if the search query matches the name or phone number (convert to lowercase for case-insensitivity)
          //       final searchQuery = controller.searchQuery.toLowerCase();
          //       final nameMatch = user.name?.toLowerCase().contains(searchQuery) ?? false;
          //       final phoneMatch = user.mobileNo?.contains(searchQuery) ?? false;
          //       return nameMatch || phoneMatch;
          //     })
          //     .toList();
          List<RegisteredUserDataModal> filteredUsers = controller.getRegisteredUserList
              .where((user) => user.name != null) // Remove users with null names
              .where((user) {
            final searchQuery = controller.searchQuery.toLowerCase();
            final nameMatch = user.name!.toLowerCase().contains(searchQuery);
            final phoneMatch = user.mobileNo?.contains(searchQuery) ?? false;
            return nameMatch || phoneMatch;
          })
              .toList()
            ..sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase())); // Sort by name


          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: customDrawerController.isDarkMode == false?
                          [AppColor.cardbg, AppColor.cardbg]:
                          [Colors.transparent, Colors.white10],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,

                        )
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        controller.updateSearchQuery(value);
                      },
                      cursorColor: AppColor.color,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        //customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search Username..",
                        hintStyle: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color),
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
                //                             ? AppColor.color
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
                //                               color: AppColor.color,
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
                    Text("SUGGESTIONS", style: MyTextTheme.greyNormal.copyWith(color: Theme.of(context).textTheme.titleSmall?.color),),
                  ],
                ),

          if (filteredUsers.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        "No Suggestions.",
                        style: MyTextTheme.mediumGCB.copyWith(color: Theme.of(context).textTheme.titleSmall?.color),
                      ),
                    ),
                  ),
              // Expanded(
              //     child:
              //       ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: filteredUsers.length,
              //         itemBuilder: (context, index) {
              //           RegisteredUserDataModal registeredData = filteredUsers[index];
              //           log("controller.invitedFriendList ${controller.invitedFriendList}");
              //           var matchedRequest = controller.invitedFriendList.firstWhere((request) => request['sender']['id'].toString() == registeredData.userId.toString(),
              //             orElse: () => null,     );
              //
              //           print("Matched Request Status: ${matchedRequest != null ? matchedRequest['status_display'] : 'No request'}");
              //
              //           print("matchedRequest $matchedRequest");
              //           print("registeredData.userId ${registeredData.userId}");
              //           print("registeredData.userId ${registeredData.name}");
              //           print("registeredData.userId ${registeredData.mobileNo}");
              //           print("Item${registeredData.picture}");
              //           return Padding(
              //             padding: const EdgeInsets.fromLTRB(5,8,5,8),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: 35,
              //                       height: 40,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         image: registeredData.picture != null && registeredData.picture!.isNotEmpty
              //                             ? DecorationImage(
              //                           image: NetworkImage("http://182.156.200.177:8011${registeredData.picture}"),
              //                           fit: BoxFit.cover,
              //                         )
              //                             : null,
              //                         color: registeredData.picture == null || registeredData.picture!.isEmpty
              //                             ? AppColor.color
              //                             : null,
              //                       ),
              //                       child: registeredData.picture == null || registeredData.picture!.isEmpty
              //                           ? const Icon(Icons.person, size: 20, color: Colors.white)
              //                           : null,
              //                     ),
              //                     const SizedBox(width: 10,),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           capitalizeFirstLetter(registeredData.name.toString()),
              //                           style: MyTextTheme.mediumGCB.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color,fontWeight: FontWeight.bold)
              //                         ),
              //                         // SizedBox(height: 20,),
              //                         Text(
              //                             registeredData.username.toString(),
              //                           style: MyTextTheme.smallGCB
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //
              //                   InkWell(
              //                     onTap: () async {
              //                       if(matchedRequest==null){
              //                         await controller.sendFriendRequest(registeredData);
              //                         controller.checkInviteStatus(UserData().getUserData!.id.toString());
              //
              //                       }
              //                     },
              //                     child:matchedRequest ==null?
              //                     Container(
              //                       height: 30,
              //                       width: 80,
              //                       decoration: BoxDecoration(
              //                        // border: Border.all(color: AppColor.white),
              //                         borderRadius: BorderRadius.circular(10),
              //                         color: AppColor.color,
              //                       ),
              //                       child:  const Center(
              //                         child: Text("Request", style: TextStyle(color: Colors.white)),
              //                       ),
              //                     )
              //                         :
              //                     Container(
              //                       height: 30,
              //                       width: 80,
              //                       decoration: BoxDecoration(
              //                         borderRadius: BorderRadius.circular(10),
              //                         color:matchedRequest['status_display']=="Accepted"? Colors.green:AppColor.greyColor,
              //                       ),
              //                       child:  Center(
              //                         child: Text(matchedRequest['status_display'], style: const TextStyle(color: Colors.white)),
              //                       ),
              //                     ),
              //
              //                   ),
              //
              //
              //               ]
              //             ),
              //           );
              //         },
              //       ),
              //     ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      RegisteredUserDataModal registeredData = filteredUsers[index];
                      log("controller.invitedFriendList ${controller.invitedFriendList}");
                      // Get the current user's ID
                      String currentUserId = UserData().getUserData!.id.toString();

                      // Check for a matched request where the current user is either the sender or the receiver
                      var matchedRequest = controller.invitedFriendList.firstWhere(
                            (request) =>
                        (request['sender']['id'].toString() == registeredData.userId.toString() &&
                            request['receiver']['id'].toString() == currentUserId) ||
                            (request['receiver']['id'].toString() == registeredData.userId.toString() &&
                                request['sender']['id'].toString() == currentUserId),
                        orElse: () => null,
                      );

                      print("Matched Request Status: ${matchedRequest != null ? matchedRequest['status_display'] : 'No request'}");

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
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
                                        ? AppColor.color
                                        : null,
                                  ),
                                  child: registeredData.picture == null || registeredData.picture!.isEmpty
                                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      capitalizeFirstLetter(registeredData.name.toString()),
                                      style: MyTextTheme.mediumGCB.copyWith(
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      registeredData.username.toString(),
                                      style: MyTextTheme.smallGCB,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                if (matchedRequest == null) {
                                  await controller.sendFriendRequest(registeredData);
                                  controller.checkInviteStatus(currentUserId);
                                }
                              },
                              child: matchedRequest == null
                                  ? Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.color,
                                ),
                                child: const Center(
                                  child: Text("Request", style: TextStyle(color: Colors.white)),
                                ),
                              )
                                  : Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: matchedRequest['status_display'] == "Accepted" ? Colors.green : AppColor.greyColor,
                                ),
                                child: Center(
                                  child: Text(matchedRequest['status_display'], style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
