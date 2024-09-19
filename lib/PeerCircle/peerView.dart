import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/peerController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';

import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';

class PeerView extends GetView<PeerController>{
  @override
  Widget build(BuildContext context) {
    final SearchController _searchController = Get.put(SearchController());
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       title: Text('Peer Circle',style: MyTextTheme.mediumBCD,),
       bottom:  PreferredSize(
         preferredSize: Size.fromHeight(1.0),
         child: Divider(
             height: 1.0,
             color: AppColor.packageGray
         ),
       ),
       leading: InkWell(
           onTap: (){
             Get.back();
           },
           child: Icon(Icons.arrow_back_ios_new)),
       actions: [
         TextButton(
             onPressed: (){
               Get.toNamed(AppRoutes.addfriendRoute);
             },
             child: Text("+ Add",style: MyTextTheme.mustard,))
       ],
     ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 20,),
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
          SizedBox(height: 20),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.peers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://placekitten.com/200/200'),
                  ),
                  title: Text(controller.peers[index]['name']),
                  subtitle: Text(controller.peers[index]['phone']),
                  trailing: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20,),
                                Image.asset(
                                  "assets/container.png",
                                  // width: screenWidth * 0.1,
                                  width: 40,
                                  height: 50,
                                ),
                                SizedBox(height: 16),
                                Text("ARE YOU SURE?",style: MyTextTheme.mustard,),

                                SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // First Button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.circleIndicator,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // Action for the first button
                                      },
                                      child: Text(
                                        'No, Go Back',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // Second Button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // Action for the second button
                                      },
                                      child: Text(
                                        ' yes,Remove',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      ),
                                    ),
                                  )
                                ]
                              ),
                            ),
                                SizedBox(height: 20,)
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Remove',
                      style: TextStyle(color: AppColor.circleIndicator),
                    ),
                  ),


                );
              },
            )),
          ),


        ],
      ),
    )

   );
  }

}
