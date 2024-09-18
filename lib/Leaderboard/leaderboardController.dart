import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import 'leaderboardDataModal.dart';

class LeaderBoardController extends GetxController{

  var selectedDate = DateTime.now().obs;
  var selectedTab = 'Daily'.obs;

  void updateSelectedDate(DateTime picked) {
  selectedDate.value = picked;
  }

  void updateSelectedTab(String tab) {
  selectedTab.value = tab;

  }

  leaderboard() async{

    var request = http.Request('GET', Uri.parse('http://172.16.61.15:8011/adhanapi/prayer-response/17-09-2024/?user_id=2'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var decodeData = jsonDecode(await response.stream.bytesToString());
      print(decodeData);
      updateLeaderboardList = decodeData['records'];
      print("@@@@@@@@@@@@ "+getLeaderboardList.toList().toString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  List leaderboardList = [];
  List<LeaderboardDataModal> get getLeaderboardList => List<LeaderboardDataModal>.from(
      leaderboardList.map((element) => LeaderboardDataModal.fromJson(element)).toList());
  set updateLeaderboardList(List val){
    leaderboardList = val;
    update();
  }

  List staticData = [
    {
      'id':0,
      'image':"assets/bg.jpeg",
      'isFirst':1
    },
    {
      'id':0,
      'image':"assets/bg.jpeg",
      'isFirst':1
    },
    {
      'id':0,
      'image':"assets/bg.jpeg",
      'isFirst':1
    },
    {
      'id':0,
      'image':"assets/bg.jpeg",
      'isFirst':1
    },
    {
      'id':0,
      'image':"assets/bg.jpeg",
      'isFirst':1
    },
  ];



}