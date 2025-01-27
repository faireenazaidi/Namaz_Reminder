import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Profile/profileView.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../AppManager/dialogs.dart';
import '../Widget/MyRank/myRankController.dart';
import '../Widget/MyRank/myweeklyrank.dart';
import '../main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());
    final DashBoardController dashBoardController = Get.find();
    final MyRankController myRankController = Get.put(MyRankController());
    print(dashBoardController.missedPrayersCount.toString(),);
    return SafeArea(
      top: true,
      child: Drawer(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight:  Radius.circular(5),
              )
          ),
          width: 280,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                GetBuilder<DashBoardController>(
                    builder: (controller){
                      return  Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 20.0,left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0,),
                                    child: CircleAvatar(
                                      radius: 31,
                                      backgroundColor: AppColor.circleIndicator,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: customDrawerController.userData.getUserData!.picture.isNotEmpty
                                            ? NetworkImage("http://182.156.200.177:8011${customDrawerController.userData.getUserData!.picture}")
                                            : null,
                                        backgroundColor: customDrawerController.userData.getUserData!.picture.isEmpty
                                            ? AppColor.packageGray
                                            : Colors.transparent,
                                        child: customDrawerController.userData.getUserData!.picture.isEmpty
                                            ?  Icon(Icons.person, size: 25, color: AppColor.circleIndicator)
                                            : null,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        Get.to(
                                              () => ProfileView(),
                                          transition: Transition.rightToLeft,
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Text(
                                            UserData().getUserData!.name.toString().toUpperCase(),
                                            style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color )
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                            UserData().getUserData!.mobileNo??'',
                                            style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color ),
                                          ),
                                          const SizedBox(height: 5,),
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
                          Positioned(
                            left: 50,
                            bottom: 40,
                            child: Stack(
                              children: [
                                SvgPicture.asset(myRankController.rank==1?'assets/Gold.svg'
                                    :myRankController.rank == 2?'assets/silver.svg':
                                myRankController.rank == 3?'assets/Bronze.svg':'assets/other.svg',height: 25,),
                                Positioned(
                                  right: 9,
                                  bottom: 3,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: MyRank(
                                          rankedFriends: dashBoardController.weeklyRanked,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ]
                    );
                  }
              ),

              const SizedBox(height: 10,),
                Divider(
                  color: Theme.of(context).dividerColor,
                ),
                const SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.leaderboardRoute);
                },


                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/icon.svg",color:Theme.of(context).iconTheme.color,),
                      const SizedBox(width: 6,),
                      Text("Leaderboard",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.missedPrayers);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/missed.svg",color:Theme.of(context).iconTheme.color ,),
                          const SizedBox(width: 6),
                          Text(
                            "Missed Prayers",
                            style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                          ),
                        const Spacer(),
                          Obx((){
                            if (dashBoardController.missedPrayersCount.value == 0) {
                              return const SizedBox();
                            }
                            return  Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                (dashBoardController.missedPrayersCount.value - 1).toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),

                SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.peerRoute);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/pc.svg",color:Theme.of(context).iconTheme.color ,),
                          const SizedBox(width: 6),
                          Text(
                            "Peer Circle",
                            style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                          ),
                          const Spacer(),
                         Obx((){
                           if (dashBoardController.pending.value == 0) {
                             return SizedBox();
                           }
                           return  Container(
                             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                             decoration: BoxDecoration(
                               color: AppColor.circleIndicator,
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: Text(
                               dashBoardController.pending.value.toString(),
                               style: const TextStyle(
                                 color: Colors.white,
                                 fontSize: 12,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),

                           );
                         })
                        ],
                      ),
                    ),
                  ),

              SizedBox(height: 10,),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.notifications);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset( "assets/notifi.svg",color:Theme.of(context).iconTheme.color ,),
                        const SizedBox(width: 6,),
                        Text("Notifications",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.settingRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/set.svg",color:Theme.of(context).iconTheme.color ,),
                      SizedBox(width: 6,),
                      Text("Settings",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                    ],
                  ),
                ),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/dm.svg",color:Theme.of(context).iconTheme.color ,),
                      const SizedBox(width: 6,),
                      Text("Dark Mode",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                      Spacer(),
                      Obx(() => Switch(
                        thumbIcon: WidgetStateProperty.all(
                          const Icon(Icons.circle, color: Colors.white),
                        ),
                        activeTrackColor: AppColor.circleIndicator,
                        activeColor: AppColor.white,
                        inactiveTrackColor:  customDrawerController.isDarkMode == false ? AppColor.switchin: Colors.white12,
                        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                        inactiveThumbColor: Colors.white,
                        value: customDrawerController.isDarkMode.value,
                        onChanged: (value) {
                          customDrawerController.toggleDarkMode(value);
                          Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                        },
                      ))
                    ],
                  ),
                ),
              Divider(
                color: Theme.of(context).dividerColor,
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.faqsRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/fq.svg",color:Theme.of(context).iconTheme.color ,),
                      const SizedBox(width: 6,),
                      Text("FAQs",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.feedback);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/feed.svg",color:Theme.of(context).iconTheme.color ,),
                      SizedBox(width: 6,),
                      Text("Feedback",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Dialogs.actionBottomSheet(subTitle: 'Do you want to logout?',okButtonName: 'Yes' ,okButtonColor: Colors.white,
                      okPressEvent: ()async{
                        await UserData().removeUserData();
                        dashBoardController.locationController.value.clear;
                        stopBackgroundService();
                        Get.offAllNamed(AppRoutes.locationPageRoute);
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset( "assets/logout.svg",color:Theme.of(context).iconTheme.color ,),
                      const SizedBox(width: 6,),
                      Text("Logout",style: MyTextTheme.smallBC.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color) ,),
                    ],
                  ),
                ),
             ),
              const SizedBox(height: 10,),
            ],
            ),
        )));
  }
}
