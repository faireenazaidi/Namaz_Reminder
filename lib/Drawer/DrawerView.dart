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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   backgroundImage: NetworkImage( "http://182.156.200.177:8011${UserData().getUserData!.picture}"),
                      //   radius: 30,
                      // ),
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

                      // Container(
                     //    width: 40,
                     //    height: 40,
                     //      decoration: BoxDecoration(
                     //      shape: BoxShape.circle,
                     //      image: customDrawerController.userData.getUserData!.picture.isNotEmpty
                     //          ? DecorationImage(
                     //        image: NetworkImage("http://182.156.200.177:8011${customDrawerController.userData.getUserData!.picture}"),
                     //        fit: BoxFit.cover,
                     //      )
                     //          : null,
                     //      color: customDrawerController.userData.getUserData!.picture.isEmpty
                     //          ? Colors.orange
                     //          : null,
                     //    ),
                     //    child: customDrawerController.userData.getUserData!.picture.isEmpty
                     //        ? const Icon(Icons.person, size: 16, color: Colors.white)
                     //        : null,
                     //  ),
                      const SizedBox(width: 17),
                      Expanded(
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
                                InkWell(
                                    onTap: (){
                                      Get.toNamed(AppRoutes.profileRoute);
                                    },
                                    child: Text("Edit Profile",style: MyTextTheme.mustardNn,))
                              ],
                            ),

                          ],
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
                // ListTiles
                // _buildListTile(
                //     context, "Dashboard", "assets/dashboard.png", () {
                //       Get.toNamed(AppRoutes.dashboardRoute);
                // }
                // ),
                // _buildListTile(
                //     context, "Support Center", "assets/supportCentre.png", () {}
                // ),
                // _buildListTile(
                //     context, "Widgets", "assets/widgets.png", () {}
                // ),
                // Obx(() => _buildListTile(
                //   context,
                //   "Notifications",
                //   "assets/notification.png",
                //       () {},
                //   customDrawerController.notificationCount.value,
                // )),
                // Divider(
                //   color: AppColor.greyLight,
                //   thickness: 1.4,
                //   endIndent: 10,
                //   indent: 10,
                // // ),
                // Obx(() => _buildListTile(
                //   context,
                //   SvgPicture.asset(
                //     "assets/icon.svg", // Replace with your SVG file
                //     height: 24.0, // Adjust the height if needed
                //     width: 24.0,  // Adjust the width if needed
                //   ),
                //       () {
                //     Get.toNamed(AppRoutes.leaderboardRoute);
                //   },
                //   customDrawerController.leaderboardCount.value,
                // )),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/icon.svg"
                  ),
                  title: Text("Leaderboard",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.leaderboardRoute);
                  },
                ),

                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/missed.svg"
                  ),
                  title: Text("Missed Prayers",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Get.toNamed(AppRoutes.missedPrayers);
                  },
                ),

                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/pc.svg"
                  ),
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
                  title: Text("Support Center",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/noti.svg"
                  ),
                  title: Text("Notifications",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
                ),
                // Obx(() => ListTile(
                //   leading: Image.asset("assets/darkMode.png"),
                //   title: const Text(
                //     'Dark Mode',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 12,
                //       fontFamily: 'Roboto',
                //     ),
                //   ),
                //   dense: true, // Reduce spacing
                //   contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Reduce padding
                //   trailing: Switch(
                //     value: customDrawerController.isDarkMode.value,
                //     onChanged: (value) {
                //       customDrawerController.toggleDarkMode(value);
                //       Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                //     },
                //   ),
                // )),
                // Obx(() => ListTile(
                //   leading: Image.asset("assets/darkMode.png"),
                //   title: const Text(
                //     'Dark Mode',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 12,
                //       fontFamily: 'Roboto',
                //     ),
                //   ),
                //   dense: true, // Reduce spacing
                //   contentPadding: EdgeInsets.symmetric(horizontal: 12), // Reduce padding
                //   trailing: Switch(
                //     value: customDrawerController.isDarkMode.value,
                //     onChanged: (value) {
                //       customDrawerController.toggleDarkMode(value);
                //       Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                //     },
                //   ),


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
                  title: Text("Setting",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
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
                  title: Text("F&Q",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
                ),
                ListTile(
                  leading:  SvgPicture.asset(
                      "assets/feed.svg"
                  ),
                  title: Text("Feedback",style: MyTextTheme.smallBC ,),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Coming Soon");                },
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0,bottom: 20,top: 8),
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: Colors.grey.shade500,size: 18,),
                        const SizedBox(width: 25,),
                        const Text("Logout",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12, // Smaller text
                          fontFamily: 'Roboto', // Roboto font
                        ))
                      ],
                    ),
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
      // trailing: count != null && count > 0
      //     ? CircleAvatar(
      //   radius: 10,
      //   backgroundColor: Colors.orange,
      //   child: Text(
      //     count.toString(),
      //     style: const TextStyle(color: Colors.white, fontSize: 12),
      //   ),
      // )
      //     : null,
      onTap: onTap,
    );
  }
}
