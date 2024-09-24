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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  // controller: controller.nameC.value,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("FRIEND REQUESTS",style: MyTextTheme.largeBCB,),
                    InkWell(
                      onTap: (){
                        Get.to(()=>SeeAll());
                      },
                        child: Text("See All"))
                  ],
                ),

                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getFriendRequestList.length,
                    itemBuilder: (context, index) {
                      FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
                      print("!!!!!!!!!!" + friendRequestData.name.toString());

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
                                  height: 30,
                                  width: 80,
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
                                onTap: ()  {

                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.white),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
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
                ),
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("REGISTERED USERS",style: MyTextTheme.largeBCB,),
                  ],
                ),
                SizedBox(height: 10,),


                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getRegisteredUserList.length,
                    itemBuilder: (context, index) {
                      RegisteredUserDataModal registeredData = controller.getRegisteredUserList[index];
                      print("?????????"+registeredData.name.toString());

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20,
                                child: Icon(Icons.person,color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(registeredData.name.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold ),),
                                    Text(registeredData.mobileNo.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 14,),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await controller.sendFriendRequest(registeredData);
                            },
                            child: Container(
                              height: 30,width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.white),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.circleIndicator
                              ),
                              child: Center(child: Text("Invite",style: TextStyle(color: Colors.white),)),
                            ),
                          )


                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
      ),



    );
  }


}