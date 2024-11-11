import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:namaz_reminders/DashBoard/dashboardBinding.dart';
import 'package:namaz_reminders/DashBoard/dashboardView.dart';
import 'package:namaz_reminders/FAQs/FAQsBinding.dart';
import 'package:namaz_reminders/FAQs/FAQsView.dart';
import 'package:namaz_reminders/Feedback/feedbackBinding.dart';
import 'package:namaz_reminders/Feedback/feedbackView.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardBinding.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardView.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageBinding.dart';
import 'package:namaz_reminders/LocationSelectionPage/locationPageView.dart';
import 'package:namaz_reminders/Missed%20Prayers/missed_orayers_binding.dart';
import 'package:namaz_reminders/Missed%20Prayers/missed_prayers_view.dart';
import 'package:namaz_reminders/Notification/notificationBindings.dart';
import 'package:namaz_reminders/Notification/notificationView.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendBinding.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendView.dart';
import 'package:namaz_reminders/PeerCircle/peerView.dart';
import 'package:namaz_reminders/Profile/profileController.dart';
import 'package:namaz_reminders/Profile/profileView.dart';
import 'package:namaz_reminders/Setting/SettingBinding.dart';
import 'package:namaz_reminders/SplashScreen/splashBinding.dart';
import 'package:namaz_reminders/UpcomingPrayers/upcomingController.dart';
import '../Login/loginBinding.dart';
import '../Login/loginView.dart';
import '../PeerCircle/peerBinding.dart';
import '../Profile/profileBinding.dart';
import '../Setting/SettingView.dart';
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
  static const String profileRoute = '/profile';
  static const String peerRoute = '/peer';
  static const String addfriendRoute = '/friend';
  static const String missedPrayers = '/missed_prayers';
  static const String notifications = '/notification';
  static const String settingRoute = '/setting';
  static const String feedback = '/feed';
  static const String faqsRoute = '/faqs';





  static List<GetPage> pages = [

    GetPage(
      name: loginRoute,
      page: () =>   LoginView(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: dashboardRoute,
      page: () =>  const DashBoardView(),
      binding: DashBoardBinding(),
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
    GetPage(
      name: profileRoute,
      page: () =>  ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: peerRoute,
      page: () =>  PeerView(),
      binding: PeerBinding(),
    ),
    GetPage(
      name: addfriendRoute,
      page: () =>  AddFriendView(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: missedPrayers,
      page: () =>  const MissedPrayersView(),
      binding: LeaderBoardBinding(),
    ),
    GetPage(
      name: notifications,
      page: () => NotificationView(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: settingRoute,
      page: () => SettingView(),
      binding: SettingBindings(),
    ),
    GetPage(
      name: feedback,
      page: () => FeedbackView(),
      binding: FeedbackBindings(),
    ),
    GetPage(
      name: faqsRoute,
      page: () => FAQSView(),
      binding: FAQsBindings(),
    ),
  ];
}
