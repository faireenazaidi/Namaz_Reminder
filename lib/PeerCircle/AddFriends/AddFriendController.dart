import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'AddFriendDataModal.dart';

class AddFriendController extends GetxController {
  var requests = <Person>[].obs;
  var contacts = <Person>[].obs;
  var nearbyPeople = <Person>[].obs;
  var registeredUsers = <Person>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRegisteredUsers();
    fetchFriendRequests();
  }


  /// Register USer Method

  Future<void> fetchRegisteredUsers() async {
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/registered-users/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("APIDATA:"+data.toString());
        updateRegisteredList = data['users'];
        print("DDDDDDDD"+getRegisteredUserList.toString());

      } else {
        print('Failed to fetch registered users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching registered users: $e');
    }
  }

  List registeredUserList =[];
  List<RegisteredUserDataModal> get getRegisteredUserList => List<RegisteredUserDataModal>.from(
      registeredUserList.map((element) => RegisteredUserDataModal.fromJson(element)).toList());
  set updateRegisteredList(List val){
    registeredUserList = val;
    update();
  }


  /// Friend request List


  Future<void> fetchFriendRequests() async {
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/friend-requests/?user_id=8');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var  data = json.decode(response.body);
        print("555 "+data.toString());

        updateFriendRequestList = data;


      } else {
        print('Failed to fetch friend requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching friend requests: $e');
    }
  }



  List friendRequestList = [];
  List<FriendRequestDataModal> get getFriendRequestList => List<FriendRequestDataModal>.from(
      registeredUserList.map((element) => FriendRequestDataModal.fromJson(element)).toList());
  set updateFriendRequestList(List val){
    friendRequestList = val;
    update();
  }


  ///Invite Friends


  sendFriendRequest(RegisteredUserDataModal registeredData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://182.156.200.177:8011/adhanapi/send-friend-request/'));
    request.body = json.encode({
      "receiver_id": registeredData.userId.toString(),
      "sender_id": 9
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    print("dddd "+data.toString());
    Get.snackbar('Success', data['detail'].toString(), snackPosition: SnackPosition.BOTTOM);
    // if (response.statusCode == 200) {
    //   //print(await response.stream.bytesToString());
    //
    // }
    // else {
    // print(response.reasonPhrase);
    // }

  }



  Future<void> acceptFriendRequest(String requestId) async {
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/accept-friend-request/');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'request_id': requestId,
        }),
      );

      if (response.statusCode == 200) {
        print('Friend request accepted');
        fetchFriendRequests();
      } else {
        print('Failed to accept friend request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error accepting friend request: $e');
    }
  }
}