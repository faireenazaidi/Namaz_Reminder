import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Leaderboard/leaderboardController.dart';
import 'package:namaz_reminders/Widget/appColor.dart';

class LeaderBoardView extends GetView<LeaderBoardController>{
  const LeaderBoardView({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
   body: Stack(
     children: [
       Text("Leaderboard"),
       Container(
         color: AppColor.cream,
       ),
       Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage("assets/blacknet.png"),
           ),
         ),
       )
     ],
   ),


   );
  }

}