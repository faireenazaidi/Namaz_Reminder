import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendController.dart';
import '../../Widget/appColor.dart';
import '../../Widget/text_theme.dart';
import 'AddFriendDataModal.dart';

class SeeAll extends GetView<AddFriendController>{
  const SeeAll({super.key});

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
     body:  GetBuilder(
       init: controller,
       builder: (_) {
         return Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             shrinkWrap: true,
             itemCount: controller.getFriendRequestList.length,
             itemBuilder: (context, index) {
               FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
               print("!!!!!!!!!!${friendRequestData.name}");
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
                             ? AppColor.color
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
                             await controller.acceptFriendRequest(friendRequestData);
                             print("FaheemCheck");
                           },
                           child: Container(
                             height: MediaQuery.of(context).size.height * 0.04,
                             width: MediaQuery.of(context).size.width * 0.2,
                             decoration: BoxDecoration(
                               border: Border.all(color: AppColor.white),
                               borderRadius: BorderRadius.circular(10),
                               color: AppColor.color,
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
                               color: AppColor.greyColor,
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
         );
       }
     ),
   );
  }
}