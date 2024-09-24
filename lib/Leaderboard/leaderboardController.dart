import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';

import '../Services/user_data.dart';
import 'leaderboardDataModal.dart';

class LeaderBoardController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    print("Date:$formattedDate");
    ;
  }

  String getFormattedDate() {
    // Get the current date and format it
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  var selectedDate = DateTime.now().obs;
  var selectedTab = 'Daily'.obs;

  void updateSelectedDate(DateTime picked) {
  selectedDate.value = picked;
  }

  void updateSelectedTab(String tab) {
  selectedTab.value = tab;

  }


  leaderboard(formattedDate) async{
    print(getFormattedDate);

    var request = http.Request('GET', Uri.parse('http://182.156.200.177:8011/adhanapi/prayer-response-friend/?user_id=4&date=24-09-2024'));


    http.StreamedResponse response = await request.send();
    print(request.url);

    if (response.statusCode == 200) {
     // print(await response.stream.bytesToString());
      var decodeData = jsonDecode(await response.stream.bytesToString());
      print("decodeData $decodeData");
      // updateLeaderboardList = decodeData;
      getLeaderboardList= LeaderboardDataModal.fromJson(decodeData);
      print("getLeaderboardList $getLeaderboardList");
      // print("@@@@@@@@@@@@ "+getLeaderboardList.toString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  Map<String,dynamic> leaderboardList = {};
  LeaderboardDataModal?  getLeaderboardList;
  // List<LeaderboardDataModal> get getLeaderboardList => List<LeaderboardDataModal>.from(
  //     leaderboardList.map((element) => LeaderboardDataModal.fromJson(element)).toList());
  set updateLeaderboardList(val){
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