import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:namaz_reminders/DashBoard/dashboardBinding.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardBinding.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardView.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageBinding.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageView.dart';
import 'package:namaz_reminders/SplashScreen/splashBinding.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import '../Login/loginBinding.dart';
import '../Login/loginView.dart';
import '../SplashScreen/splashController.dart';
import '../SplashScreen/splashView.dart';
import '../UpcomingPrayers/upcomingBindings.dart';
import '../UpcomingPrayers/upcomingView.dart';
import 'package:namaz_reminders/SplashScreen/splashController.dart';


class AppRoutes {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String leaderboardRoute = '/leaderboard';
  static const String upcomingRoute = '/upcoming';
  static const String locationPageRoute = '/locationPage';
  static const String splashRoute = '/splash';





  static List<GetPage> pages = [

    GetPage(
      name: loginRoute,
      page: () =>   LoginView(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: dashboardRoute,
      page: () =>  DashBoardView (),
      bindings: [DashBoardBinding()],
    ),
    GetPage(
      name: leaderboardRoute,
      page: () =>   LeaderBoardView(),
      bindings: [LeaderBoardBinding()],
    ),
    GetPage(
      name: upcomingRoute,
      page: () =>   Upcoming(),
        binding: UpcomingBinding(),
    ),
    GetPage(
      name: locationPageRoute,
      page: () =>  LocationPage(),
      binding: LocationPageBinding(),
    ),
    GetPage(
      name: splashRoute,
      page: () =>  SplashScreen(),
      binding: SplashBinding(),
    ),



  ];
}
