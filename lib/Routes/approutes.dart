import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:namaz_reminders/DashBoard/dashboardBinding.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardBinding.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardView.dart';
import '../Login/loginBinding.dart';
import '../Login/loginView.dart';

class AppRoutes {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String leaderboardRoute = '/leaderboard';

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



  ];
}
