import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Login/loginView.dart';
import 'Routes/approutes.dart';

void main() {
  Get.put(CustomDrawerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
    });
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the transition to the login view for 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => LoginView(), transition: Transition.circularReveal);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}
