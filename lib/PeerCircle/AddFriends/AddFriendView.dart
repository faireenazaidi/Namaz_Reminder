import 'dart:developer';
import 'dart:ffi';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: GetBuilder<AddFriendController>(
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
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
                const SizedBox(height: 10),
                Column(
                  children: [
                    Visibility(
                      visible: controller.getFriendRequestList.isNotEmpty,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("REQUESTS", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey)),
                              Visibility(
                                visible: controller.getFriendRequestList.length > 2,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => SeeAll());
                                  },
                                  child: Text("SEE ALL", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getFriendRequestList.length,
                            itemBuilder: (context, index) {
                              FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
                              RegisteredUserDataModal registeredData = filteredUsers[index];
                              print("Item${registeredData.picture}");
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
                                              image: registeredData.picture != null && registeredData.picture!.isNotEmpty
                                                  ? DecorationImage(
                                                image: NetworkImage("http://182.156.200.177:8011${registeredData.picture}"),
                                                fit: BoxFit.cover,
                                              )
                                                  : null,
                                              color: registeredData.picture == null || registeredData.picture!.isEmpty
                                                  ? Colors.orange
                                                  : null,
                                            ),
                                            child: registeredData.picture == null || registeredData.picture!.isEmpty
                                                ? const Icon(Icons.person, size: 20, color: Colors.white)
                                                : null,
                                          ),

                                          Padding(
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
                                                Text(
                                                  friendRequestData.mobileNo.toString(),
                                                  style: MyTextTheme.mediumGCB.copyWith(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await controller.acceptFriendRequest(friendRequestData);
                                          controller.acceptFriendRequest(friendRequestData);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.4,
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
                                      InkWell(
                                        onTap: () async {
                                          await controller.declineRequest(friendRequestData);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.4,
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
                    Text("REGISTERED USERS", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey)),
                  ],
                ),
                const SizedBox(height: 10),
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
                                        ? Colors.orange
                                        : null,
                                  ),
                                  child: registeredData.picture == null || registeredData.picture!.isEmpty
                                      ? const Icon(Icons.person, size: 20, color: Colors.white)
                                      : null,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, top: 12),
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
                                      Text(
                                        registeredData.mobileNo.toString(),
                                        style: MyTextTheme.mediumGCB.copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                if(matchedRequest==null){
                                  await controller.sendFriendRequest(registeredData);
                                }

                              },
                              child:matchedRequest==null? Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.circleIndicator,
                                ),
                                child: const Center(
                                  child: Text("Invite", style: TextStyle(color: Colors.white)),
                                ),
                              ):
                              Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color:matchedRequest['status_display']=="Accepted"? Colors.green:AppColor.greyColor,
                                ),
                                child:  Center(
                                  child: Text(matchedRequest['status_display'], style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
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
