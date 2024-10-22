import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/FAQs/FAQsView.dart';
import 'package:namaz_reminders/Feedback/feedbackView.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardView.dart';
import 'package:namaz_reminders/Missed%20Prayers/missed_prayers_view.dart';
import 'package:namaz_reminders/Notification/notificationView.dart';
import 'package:namaz_reminders/PeerCircle/peerView.dart';
import 'package:namaz_reminders/Profile/profileView.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'package:namaz_reminders/Setting/SettingView.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../AppManager/dialogs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return Drawer(
      backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight:  Radius.circular(5),

            )
        ),
        width: 280,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20.0,left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: customDrawerController.userData.getUserData!.picture.isNotEmpty
                              ? NetworkImage("http://182.156.200.177:8011${customDrawerController.userData.getUserData!.picture}")
                              : null,
                          backgroundColor: customDrawerController.userData.getUserData!.picture.isEmpty
                              ? AppColor.circleIndicator
                              : Colors.transparent,
                          child: customDrawerController.userData.getUserData!.picture.isEmpty
                              ? const Icon(Icons.person, size: 25, color: Colors.white)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.to(
                                  () => ProfileView(),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 550),
                              curve: Curves.ease,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text(
                                UserData().getUserData!.name.toString().toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                UserData().getUserData!.mobileNo??'',
                                style: MyTextTheme.smallGCN,
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Icon(Icons.edit,color: AppColor.circleIndicator,size: 12,),
                                  Text("Edit Profile",style: MyTextTheme.mustardNn,)
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: AppColor.greyLight,
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => LeaderBoardView(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 550),
                      curve: Curves.ease,
                    );
                  },


                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/icon.svg"),
                        SizedBox(width: 6,),
                        Text("Leaderboard",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/icon.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Leaderboard",style: MyTextTheme.smallBC ,),
                //
                //   onTap: () {
                //     Get.toNamed(AppRoutes.leaderboardRoute);
                //   },
                // ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => MissedPrayersView(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 550),
                        curve: Curves.ease,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/missed.svg"),
                        SizedBox(width: 6,),
                        Text("Missed Prayers",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),


                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/missed.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Missed Prayers",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     Get.toNamed(AppRoutes.missedPrayers);
                //   },
                // ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => PeerView(), // Replace with your target widget
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 550),
                      curve: Curves.ease,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/pc.svg"),
                        SizedBox(width: 6,),
                        Text("Peer Circle",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),



                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/pc.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Peer Circle",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     Get.toNamed(AppRoutes.peerRoute);
                //   },
                // ),

                Divider(
                  color: AppColor.greyLight,
                ),
                // SizedBox(height: 10,),
                // InkWell(
                //   onTap: () {
                //     Get.to(
                //           () => NotificationView(),
                //       transition: Transition.rightToLeft,
                //       duration: Duration(milliseconds: 550),
                //       curve: Curves.ease,
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Row(
                //       children: [
                //         SvgPicture.asset( "assets/noti.svg"),
                //         SizedBox(width: 6,),
                //         Text("Notifications",style: MyTextTheme.smallBC ,),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 10,),
                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/noti.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Notifications",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     Get.toNamed(AppRoutes.notifications);
                //     },
                // ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => SettingView(), // Replace with your target widget
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 550),
                      curve: Curves.ease,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/set.svg"),
                        SizedBox(width: 6,),
                        Text("Settings",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/set.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Settings",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     // Fluttertoast.showToast(msg: "Coming Soon");
                //     Get.toNamed(AppRoutes.settingRoute);
                //
                //   },
                // ),

                Divider(
                  color: AppColor.greyLight,
                ),
                SizedBox(height: 10,),

                // _buildListTile(
                //     context, "F&Q", "assets/fAndQ.png", () {
                //       Fluttertoast.showToast(msg: "Coming Soon");
                //
                // }
                // ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => FAQSView(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 550),
                      curve: Curves.ease,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/fq.svg"),
                        SizedBox(width: 6,),
                        Text("F&Q",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/fq.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //
                //   title: Text("F&Q",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     // Fluttertoast.showToast(msg: "Coming Soon");
                //     Get.toNamed(AppRoutes.faqsRoute);
                //
                //   },
                // ),
                InkWell(
                  onTap: () {
                    Get.to(
                          () => FeedbackView(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 550),
                      curve: Curves.ease,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/feed.svg"),
                        SizedBox(width: 6,),
                        Text("Feedback",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                // ListTile(
                //   leading:  SvgPicture.asset(
                //       "assets/feed.svg"
                //   ),
                //   dense: true,
                //   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //   title: Text("Feedback",style: MyTextTheme.smallBC ,),
                //   onTap: () {
                //     Get.toNamed(AppRoutes.feedback);
                //   },
                // ),
                InkWell(
                  onTap: (){
                    Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                        okPressEvent: ()async{
                          await UserData().removeUserData();
                          Get.offAllNamed(AppRoutes.locationPageRoute);
                        });

                    //Get.toNamed(AppRoutes.locationPageRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/logout.svg"),
                        SizedBox(width: 6,),
                        Text("Logout",style: MyTextTheme.smallBC ,),
                      ],
                    ),
                  ),
               ),
                SizedBox(height: 10,),
                // InkWell(
                //   onTap: (){
                //     Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                //         okPressEvent: ()async{
                //           await UserData().removeUserData();
                //           Get.offAllNamed(AppRoutes.locationPageRoute);
                //         });
                //
                //     //Get.toNamed(AppRoutes.locationPageRoute);
                //   },
                //
                //  child:  ListTile(
                //     leading:  SvgPicture.asset(
                //         "assets/logout.svg"
                //     ),
                //    dense: true, visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                //
                //    title: Text("Logout",style: MyTextTheme.smallBC ,),
                //       onTap: (){
                //         Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                //             okPressEvent: ()async{
                //               await UserData().removeUserData();
                //               Get.offAllNamed(AppRoutes.locationPageRoute);
                //             });
                //       },
                //   ),
                // ),

              ],
            ),
          ),
        ));
  }

  // Function to create the ListTiles with reduced padding, small and bold text
  Widget _buildListTile(BuildContext context, String title, String icon, VoidCallback onTap, [int? count]) {
    return ListTile(
      leading: Image.asset(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12, // Smaller text
          fontFamily: 'Roboto', // Roboto font
        ),
      ),
      dense: true, // Reduce spacing
      contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Reduce padding
      onTap: onTap,
    );
  }
}
