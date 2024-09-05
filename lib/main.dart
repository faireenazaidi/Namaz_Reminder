import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Login/loginView.dart';
import 'Routes/approutes.dart';
import 'main.dart';

void main() {
  Get.put(CustomDrawerController());  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      Obx((){
        final CustomDrawerController controller = Get.find<CustomDrawerController>();
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namaz Reminder',
        themeMode: controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        getPages: AppRoutes.pages,
        home: SplashScreen(),
        );
          }
            );
  }
}
class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
Future.delayed(Duration (seconds: 3), (){
  Get.off(() => LoginView(),transition: Transition.rightToLeft);
});
  return Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        Image.asset("assets/whiteNet.png"),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/mosque.png"),
            ],
          ),
        ),
      ]

    ),
  );
  }

}


