import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/user_data.dart';
import '../text_theme.dart';
import 'myRankController.dart';

class MyRank extends StatelessWidget {
  final List rankedFriends;
  final double textSize;
  final UserData userData = UserData();
  MyRank({Key? key, required this.rankedFriends, this.textSize = 12}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MyRankController myRankController = Get.put(MyRankController());
    myRankController.calculateRank(rankedFriends, userData);
    return Column(
      children: [
        Text(
          '${myRankController.rank.value}', // Reactively display rank
          style: MyTextTheme.rank.copyWith(fontSize: textSize)
        ),
      ],
    );
  }
}
