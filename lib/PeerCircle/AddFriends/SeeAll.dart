import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendController.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'AddFriendDataModal.dart';

class SeeAll extends GetView<AddFriendController>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       bottom: PreferredSize(
         preferredSize: const Size.fromHeight(1.0),
         child: Divider(
           height: 1.0,
           color: AppColor.packageGray,
         ),
       ),
       title: Text('Friend Requests', style: MyTextTheme.mediumBCD),
       leading: InkWell(
         onTap: () {
           Get.back();
         },
         child: const Icon(Icons.arrow_back_ios_new,size: 20,),
       ),
     ),
     body:  Padding(
       padding: const EdgeInsets.all(8.0),
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
                       // CircleAvatar(
                       //   backgroundColor: Colors.grey,
                       //   radius: 20,
                       //   child: Icon(Icons.person, color: Colors.white),
                       // ),
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
                               ? Colors.orange
                               : null,
                         ),
                         child: friendRequestData.picture == null || friendRequestData.picture!.isEmpty
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
   );
  }

}