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
    final SearchController _searchController = Get.put(SearchController());

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
          },
          child: const Icon(Icons.arrow_back_ios_new),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
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
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.getFriendshipList.isEmpty) {
                  return Center(child: Text('No friends found'));
                }

                return ListView.builder(
                  itemCount: controller.getFriendshipList.length,
                  itemBuilder: (context, index) {
                    Friendship  friend = controller.getFriendshipList[index];
                    // print(friend.id);
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 20,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, top: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        friend.user1.name.toString(),
                                        style: MyTextTheme.mediumGCB.copyWith(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        friend.user1.mobileNo.toString(),
                                        style: MyTextTheme.mediumGCB.copyWith(fontSize: 14),
                                      ),
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
                                          Text("ARE YOU SURE?", style: MyTextTheme.mustard),
                                          const SizedBox(height: 16),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColor.circleIndicator,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text(
                                                      'No, Go Back',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10, vertical: 5),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      await controller.removeFriend(friend.user1.id.toString());
                                                      controller.getFriendshipList.remove(index);                                                    },
                                                    child: const Text(
                                                      'Yes, Remove',
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10, vertical: 5),
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
                                  style: TextStyle(color: AppColor.circleIndicator)),
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
      ),
    );
  }
}


