import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/DashBoard/dashboardController.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/Drawer/drawerController.dart';
import 'package:namaz_reminders/Login/loginView.dart';
import 'Login/loginController.dart';
import 'Routes/approutes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(DashBoardController());
  Get.put(LoginController());
  Get.put(CustomDrawerController());
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CustomDrawerController customDrawerController = Get.put(CustomDrawerController());

    return Obx(() {
      return GetMaterialApp(
        initialRoute: AppRoutes.loginRoute,
        getPages: AppRoutes.pages,
        debugShowCheckedModeBanner: false,
        title: 'Namaz Reminders',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: customDrawerController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        home: LoginView(),
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
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => DashBoardView(), transition: Transition.circularReveal);
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
