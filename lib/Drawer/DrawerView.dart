import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../AppManager/dialogs.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return Drawer(
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
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CircleAvatar(
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
                      const SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(AppRoutes.profileRoute);
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
                Divider(
                  color: AppColor.greyLight,
                  thickness: 1.4,
                  endIndent: 10,
                  indent: 10,
                ),

                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/icon.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Leaderboard",style: MyTextTheme.smallBC ,),

                  onTap: () {
                    Get.toNamed(AppRoutes.leaderboardRoute);
                  },
                ),

                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/missed.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Missed Prayers",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.missedPrayers);
                  },
                ),

                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/pc.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Peer Circle",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.peerRoute);
                  },
                ),

                Divider(
                  color: AppColor.greyLight,
                  thickness: 1.4,
                  endIndent: 10,
                  indent: 10,
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/sc.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Support Center",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/noti.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Notifications",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.notifications);
                    },
                ),

                Divider(
                  color: AppColor.greyLight,
                  thickness: 1.4,
                  endIndent: 10,
                  indent: 10,
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/set.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                  title: Text("Setting",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    // Fluttertoast.showToast(msg: "Coming Soon");
                    Get.toNamed(AppRoutes.settingRoute);

                  },
                ),
                // _buildListTile(
                //     context, "F&Q", "assets/fAndQ.png", () {
                //       Fluttertoast.showToast(msg: "Coming Soon");
                //
                // }
                // ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/fq.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),

                  title: Text("F&Q",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    // Fluttertoast.showToast(msg: "Coming Soon");
                    Get.toNamed(AppRoutes.faqsRoute);

                  },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/feed.svg"
                  ),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -1,horizontal: -4),

                  title: Text("Feedback",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.feedback);
                  },
                ),
                InkWell(
                  onTap: (){
                    Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                        okPressEvent: ()async{
                          await UserData().removeUserData();
                          Get.offAllNamed(AppRoutes.locationPageRoute);
                        });

                    //Get.toNamed(AppRoutes.locationPageRoute);
                  },

                 child:  ListTile(
                    leading:  SvgPicture.asset(
                        "assets/logout.svg"
                    ),
                   dense: true,
                   visualDensity: VisualDensity(vertical: -1,horizontal: -4),
                   title: Text("Logout",style: MyTextTheme.smallBC ,),
                      onTap: (){
                        Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                            okPressEvent: ()async{
                              await UserData().removeUserData();
                              Get.offAllNamed(AppRoutes.locationPageRoute);
                            });
                      },
                  ),
                ),

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
