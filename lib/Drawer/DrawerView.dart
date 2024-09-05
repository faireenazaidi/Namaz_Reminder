import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Routes/approutes.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return Drawer(
      child: Container(
        child: ListView(
          children: [
            SizedBox(height: 10,),
            // Custom user account header
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://media.istockphoto.com/id/1409155424/photo/head-shot-portrait-of-millennial-handsome-30s-man.webp?a=1&b=1&s=612x612&w=0&k=20&c=Q5Zz9w0FulC0CtH-VCL8UX2SjT7tanu5sHNqCA96iVw="),
                    radius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Obx(() => Text(
                          customDrawerController.userName.value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Obx(() => Text(
                          customDrawerController.email.value,
                          style: MyTextTheme.smallGCN,
                        )),
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
            ListTile (
              leading: Image.asset("assets/dashboard.png"),
              title: const Text('Dashboard',),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/supportCentre.png"),
              title: const Text('Support Center'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/widgets.png"),
              title: const Text('Widgets'),
              onTap: () {},
            ),
            Obx(() => ListTile(
              leading: Image.asset("assets/notification.png"),
              title: const Text('Notifications'),
              trailing: customDrawerController.notificationCount.value > 0
                  ? CircleAvatar(
                radius: 10,
                backgroundColor: Colors.orange,
                child: Text(
                  customDrawerController.notificationCount.value.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
                  : null,
              onTap: () {},
            )),
            Divider(
              color: AppColor.greyLight,
              thickness: 1.4,
              endIndent: 10,
              indent: 10,
            ),
            Obx(() => ListTile(
              leading: Image.asset("assets/leaderboard.png"),
              title: const Text('Leaderboard'),
              trailing: customDrawerController.leaderboardCount.value > 0
                  ? CircleAvatar(
                radius: 10,
                backgroundColor: Colors.orange,
                child: Text(
                  customDrawerController.leaderboardCount.value.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
                  : null,
              onTap: () {
                Get.toNamed(AppRoutes.leaderboardRoute);
              },
            )),
            ListTile(
              leading: Image.asset("assets/reminders.png"),
              title: const Text('Reminders'),
              onTap: () {},
            ),
            Obx(() => ListTile(
              leading: Image.asset("assets/missedPrayer.png"),
              title: const Text('Missed Prayers'),
              trailing: customDrawerController.missedPrayersCount.value > 0
                  ? CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  customDrawerController.missedPrayersCount.value.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
                  : null,
              onTap: () {},
            )),
            ListTile(
              leading: Image.asset("assets/peerCircle.png"),
              title: const Text('Peer Circle'),
              onTap: () {},
            ),
            Divider(
              color: AppColor.greyLight,
              thickness: 1.4,
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
              leading: Image.asset("assets/translate.png"),
              title: const Text('Language'),
              subtitle: const Text('English'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/darkMode.png"),
              title: const Text('Dark Mode'),
              trailing: Obx(()
              {
               return Switch(
                  value: customDrawerController.isDarkMode.value,
                  onChanged: (value) {
                    customDrawerController.toggleDarkMode(value);
                    Get.changeThemeMode(value ?  ThemeMode.dark : ThemeMode.light);
                  },
                );
              })
            ),
            ListTile(
              leading: Image.asset("assets/gear.png"),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/fAndQ.png"),
              title: const Text('F&Q'),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/feedback.png"),
              title: const Text('Feedback'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
