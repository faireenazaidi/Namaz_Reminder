import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'AddFriendController.dart';
import 'AddFriendDataModal.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'SeeAll.dart';

class AddFriendView extends GetView<AddFriendController> {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    String capitalizeFirstLetter(String name) {
      if (name.isEmpty) return name;
      return name[0].toUpperCase() + name.substring(1).toLowerCase();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Invite friends', style: MyTextTheme.mediumBCD),
        leading: InkWell(
          onTap: () {
          Get.toNamed(AppRoutes.peerRoute);
          },
          child: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          List<RegisteredUserDataModal> filteredUsers = controller.getRegisteredUserList
              .where((user) => user.name?.toLowerCase().contains(controller.searchQuery.toLowerCase()) ?? false)
              .toList();
          filteredUsers.sort((a, b) {
            String nameA = a.name?.toLowerCase() ?? '';
            String nameB = b.name?.toLowerCase() ?? '';
            return nameA.compareTo(nameB);
          });

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextField(
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
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Column(
                  children: [
                    Visibility(
                      visible: controller.getFriendRequestList.isNotEmpty,
                      child: Column(
                        children: [
                          // Header Row with "REQUESTS" and optional "SEE ALL"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "REQUESTS",
                                style: MyTextTheme.greyNormal
                              ),
                              // Show "SEE ALL" only if requests are more than 2

                              Visibility(
                                visible: controller.getFriendRequestList.length > 2,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => SeeAll());
                                  },
                                  child: Text(
                                    "SEE ALL",
                                    style: MyTextTheme.greyNormal

                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          // Show ListView if request count <= 2, otherwise show only first 2 in this list
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getFriendRequestList.length <= 2
                                ? controller.getFriendRequestList.length
                                : 2, // Show only first 2 if there are more than 2 requests
                            itemBuilder: (context, index) {
                              FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
                              // RegisteredUserDataModal registeredData = filteredUsers[index];
                              // print("Item${registeredData.picture}");
                          
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    // Profile Picture
                                    Container(
                                      width: 35,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: friendRequestData.picture != null && friendRequestData.picture!.isNotEmpty
                                            ? DecorationImage(
                                          image: NetworkImage("http://182.156.200.177:8011${friendRequestData.picture}"),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                        color: friendRequestData.picture == null || friendRequestData.picture!.isEmpty
                                            ? AppColor.circleIndicator
                                            : null,
                                      ),
                                      child: friendRequestData.picture == null || friendRequestData.picture!.isEmpty
                                          ? const Icon(Icons.person, size: 20, color: Colors.white)
                                          : null,
                                    ),
                          
                                    // User Details
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0, top: 12),
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
                                            // First API call to accept the friend request
                                            // bool success = await controller.acceptFriendRequest(friendRequestData);
                                            //
                                            // if (success) {
                                            //   await controller.acceptFriendRequest(friendRequestData);
                                            //   controller.update();
                                            // }
                                            await controller.acceptFriendRequest(friendRequestData);
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
                                              child: Text("Accept", style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () async {
                                            await controller.declineRequest(friendRequestData);
                                            controller.friendRequestList.removeAt(index);
                                            controller.update();
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.04,
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColor.white),
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColor.greyDark,
                                            ),
                                            child: const Center(
                                              child: Text("Decline", style: TextStyle(color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                          
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                        "No friend found.",
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
                        print("Item${registeredData.picture}");
                        return Row(
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

                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, top: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalizeFirstLetter(registeredData.name.toString()),
                                        style: MyTextTheme.mediumGCB.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20,),


                                    ],
                                  ),
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
                                    child: Text("Invite", style: TextStyle(color: Colors.white)),
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
