import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Login/loginView.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import '../AppManager/dialogs.dart';
import '../AppManager/toast.dart';
import '../LocationSelectionPage/locationPageView.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return Drawer(
      child: SafeArea(
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
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.profileRoute);
                      },
                      child:  CircleAvatar(
                        backgroundImage: NetworkImage( "http://182.156.200.177:8011${UserData().getUserData!.picture}"),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
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
                            UserData().getUserData!.email??'',
                            style: MyTextTheme.smallGCN,
                          )
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
              // ),
              Obx(() => _buildListTile(
                context,
                "Leaderboard",
                "assets/leaderboard.png",
                    () {
                  Get.toNamed(AppRoutes.leaderboardRoute);
                },
                customDrawerController.leaderboardCount.value,
              )),


              Obx(() => _buildListTile(
                context,
                "Missed Prayers",
                "assets/missedPrayer.png",
                    () {

                      Get.toNamed(AppRoutes.missedPrayers);
                    },
                customDrawerController.missedPrayersCount.value,
              )),
              _buildListTile(
                  context, "Peer Circle", "assets/peerCircle.png", () {
                    Get.toNamed(AppRoutes.peerRoute);
              }
              ),
              Divider(
                color: AppColor.greyLight,
                thickness: 1.4,
                endIndent: 10,
                indent: 10,
              ),
              _buildListTile(
                  context, "Support Center", "assets/supportCentre.png", () {
                    Fluttertoast.showToast(msg: "Coming Soon");
              }
              ),
              Obx(() => _buildListTile(
                context,
                "Notifications",
                "assets/notification.png",
                    () {
                  Fluttertoast.showToast(msg: "Coming Soon");

                    },
                customDrawerController.notificationCount.value,
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
               )
     ),
              Divider(
                color: AppColor.greyLight,
                thickness: 1.4,
                endIndent: 10,
                indent: 10,
              ),
              _buildListTile(
                  context, "Settings", "assets/gear.png", () {
                    Fluttertoast.showToast(msg: "Coming Soon");
              }
              ),
              _buildListTile(
                  context, "F&Q", "assets/fAndQ.png", () {
                    Fluttertoast.showToast(msg: "Coming Soon");

              }
              ),
              _buildListTile(
                  context, "Feedback", "assets/feedback.png", () {
                    Fluttertoast.showToast(msg: "Coming Soon");
              }
              ),
              InkWell(
                onTap: (){
                  Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,
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
