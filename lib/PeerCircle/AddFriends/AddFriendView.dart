import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:
      GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value){
                    // controller.filterRegisteredUsers(value);
                  },
                  cursorColor: AppColor.circleIndicator,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Username..",
                    hintStyle: MyTextTheme.mediumCustomGCN,
                    // prefixIcon: Image.asset("asset/profile.png"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:  BorderSide(
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
                SizedBox(height: 10,),
                Column(
                  children: [
                    /// Using Visibility to show or hide the row and ListView based on whether the data is available
                    Visibility(
                      visible: controller.getFriendRequestList.isNotEmpty,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("REQUESTS", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey)),
                              Visibility(
                                visible: controller.getFriendRequestList.length>2,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => SeeAll());
                                  },
                                  child: Text("SEE ALL",style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey,fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.getFriendRequestList.length,
                            itemBuilder: (context, index) {
                              FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];


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
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Accept Button
                                      InkWell(
                                        onTap: () async {
                                          await controller.acceptFriendRequest(friendRequestData);
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColor.white),
                                            borderRadius: BorderRadius.circular(10),
                                            color: AppColor.circleIndicator,
                                          ),
                                          child: Center(
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
                                            color: AppColor.greyDark
                                          ),
                                          child: Center(
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

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("REGISTERED USERS", style: MyTextTheme.greyNormal.copyWith(color: AppColor.textDarkGrey)),
                  ],
                ),
                SizedBox(height: 10,),
                   Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.getRegisteredUserList.length,
                      itemBuilder: (context, index) {
                        RegisteredUserDataModal registeredData = controller.getRegisteredUserList[index];
                        // RegisteredUserDataModal invitedData = controller.getInvitedFriendList[index];
                        // var matchedRequest = invitedData.firstWhere((request) => request['receiver']['mobile_no'] == registeredData.mobileNo,orElse: () => null,     );
                        print("?????????"+registeredData.name.toString());
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // CircleAvatar(
                                //   radius: 15,
                                //   backgroundImage: registeredData.picture != null && registeredData.picture.toString().isNotEmpty
                                //       ? NetworkImage(registeredData.picture.toString()) // Display the image from the API if available
                                //       : null,
                                //   child: registeredData.picture == null || registeredData.picture.toString().isEmpty
                                //       ? Icon(Icons.person, size: 30)
                                //       : null,
                                // ),
                                registeredData.picture.toString().isEmpty?CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.orange,
                                ):
                                CachedNetworkImage(
                                  imageUrl: registeredData.picture.toString(),
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(value: downloadProgress.progress),
                                  errorWidget: (context, url, error) => const Icon(Icons.person, size: 30),
                                ),



                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0,top: 12),
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
                                      // Text(registeredData.name.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold ),),
                                      Text(registeredData.mobileNo.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 14,),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                 //            InkWell(
                 //              onTap: () async {
                 //                await controller.sendFriendRequest(registeredData);
                 //              },
                 //              child: Container(
                 //                height: 30,width: 80,
                 //                decoration: BoxDecoration(
                 //                  border: Border.all(color: AppColor.white),
                 //                  borderRadius: BorderRadius.circular(10),
                 //                  color: AppColor.circleIndicator
                 //                ),
                 //
                 //        child:
                 //         Center(child: Text("Invite",style: TextStyle(color: Colors.white),)),
                 // //        Center(
                 // //   child:  registeredData.userId.toString() ==
                 // //   controller.getInvitedFriendList.any((invited) =>
                 // // invited.userId.toString() == registeredData.userId.toString())
                 // //  ? Text("Invited") : Text("Invite"))
                 //              ),
                 //            )
                            InkWell(
                            onTap: () async {
                   await controller.sendFriendRequest(registeredData);
                 },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.circleIndicator,
                                ),
                                child: Center(
                                  child: Text("Invite",style: TextStyle(color: Colors.white),)
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
        }
      ),


    );
  }


}
