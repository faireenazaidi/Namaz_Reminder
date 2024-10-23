import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/peerController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'AddFriends/AddFriendDataModal.dart';

class PeerView extends GetView<PeerController> {
  const PeerView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final PeerController peerController = Get.put(PeerController());

    return Scaffold(
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
            // SizedBox(
            //   height: 50,
            //   child: TextField(
            //     controller: searchController,
            //     onChanged: (value) {
            //       peerController.filterFriends();
            //     },
            //     cursorColor: AppColor.circleIndicator,
            //     decoration: InputDecoration(
            //       prefixIcon: const Icon(Icons.search),
            //       hintText: "Search Username..",
            //       hintStyle: MyTextTheme.mediumCustomGCN,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: Colors.black),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: Colors.grey, width: 1),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide: const BorderSide(color: Colors.grey, width: 1),
            //       ),
            //     ),
            //     style: const TextStyle(color: Colors.grey),
            //   ),
            // ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // Update the search text in the controller as the user types
                  peerController.setSearchText(value);
                },
                cursorColor: AppColor.circleIndicator,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
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
                ),
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: GetBuilder<PeerController>(
                  builder: (_) {
                    if (peerController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (peerController.getFriendshipList.isEmpty) {
                      return Center(child: Text('No friends found'));
                    }

                    return ListView.builder(
                      itemCount: peerController.filteredFriendsList.length,
                      itemBuilder: (context, index) {
                        Friendship friend = peerController
                            .filteredFriendsList[index];
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
                                              "http://182.156.200.177:8011${friend
                                                  .user2.picture}"),
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
                                          ? const Icon(Icons.person, size: 20,
                                          color: Colors.white)
                                          : null,
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            friend.user2.name.toString(),
                                            style: MyTextTheme.mediumGCB
                                                .copyWith(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // Text(
                                          //   friend.user2.mobileNo.toString(),
                                          //   style: MyTextTheme.mediumGCB.copyWith(fontSize: 14),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Trailing TextButton for Remove
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
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .circleIndicator,
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'No, Go Back',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                        style: TextButton
                                                            .styleFrom(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius: BorderRadius
                                                            .circular(10),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          await peerController
                                                              .removeFriend(
                                                              friend.user2.id
                                                                  .toString());
                                                          peerController
                                                              .filteredFriendsList
                                                              .removeAt(index);
                                                          peerController.update();
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                          'Yes, Remove',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                        style: TextButton
                                                            .styleFrom(
                                                          padding: const EdgeInsets
                                                              .symmetric(
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
                                  child: Text('Remove', style: TextStyle(
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


    );
  }
}
