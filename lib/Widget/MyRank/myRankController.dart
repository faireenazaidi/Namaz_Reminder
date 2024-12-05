import 'package:get/get.dart';
import '../../Services/user_data.dart';

class MyRankController extends GetxController {
  final RxInt rank = 0.obs;
  late List<dynamic> sortedFriends;

  void calculateRank(List rankedFriends, UserData userData) {
    sortedFriends = List.from(rankedFriends)
      ..sort((a, b) => b['percentage'].compareTo(a['percentage']));

    rank.value = sortedFriends.indexWhere(
          (element) => element['id'].toString() == userData.getUserData!.id.toString(),
    ) + 1;
    print('hhhhhhhhh');
    print(rank.value);
  }
}
