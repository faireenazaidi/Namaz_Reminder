import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:namaz_reminders/Services/user_data.dart';
import 'AddFriendDataModal.dart';

class AddFriendController extends GetxController {
  late RegisteredUserDataModal currentUser;
  var requests = <Person>[].obs;
  var contacts = <Person>[].obs;
  var nearbyPeople = <Person>[].obs;
  var registeredUsers = <Person>[].obs;
  var isInvited = false.obs;
  var searchQuery = '';
  var invitedFriendIds = <int>[].obs;
  RxBool isLoading = true.obs;

  String loggedInUserId = '';


  UserData userData = UserData();


  @override
  void onInit() {
    super.onInit();
    checkInviteStatus(userData.getUserData!.id);
    fetchRegisteredUsers();
    fetchFriendRequests();
     // filteredUserList.value = getRegisteredUserList;


  }
  void updateSearchQuery(String query) {
    searchQuery = query;
    update();
  }
  // void setLoggedInUserId(String userId) {
  //   loggedInUserId = userId;
  //   update();
  // }


  /// Register USer Method
  Future<void> fetchRegisteredUsers() async {
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/registered-users/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("APIDATA:$data");
        updateRegisteredList = data['users'];
        int indexValue = getRegisteredUserList.indexWhere((e)=>e.userId.toString() == UserData().getUserData!.id.toString());
        updateRegisteredList = registeredUserList.removeAt(indexValue);
        update();

      } else {
        print('Failed to fetch registered users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching registered users: $e');
    }
  }

  List registeredUserList = [];

  List<RegisteredUserDataModal> get getRegisteredUserList =>
      List<RegisteredUserDataModal>.from(
          registeredUserList.map((element) =>
               RegisteredUserDataModal.fromJson(element)).toList());


  set updateRegisteredList(List val) {
    registeredUserList = val;
    update();
  }

  /// Friend request List

  Future<void> fetchFriendRequests() async {
    print("myid ${userData.getUserData!.id}");
    final url = Uri.parse('http://182.156.200.177:8011/adhanapi/friend-requests/?user_id=${userData.getUserData!.id}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("555 $data");

        updateFriendRequestList = data;
      } else {
        print('Failed to fetch friend requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching friend requests: $e');
    }
  }

  List friendRequestList = [];

  List<FriendRequestDataModal> get getFriendRequestList =>
      List<FriendRequestDataModal>.from(
          friendRequestList.map((element) =>
              FriendRequestDataModal.fromJson(element)).toList());

  set updateFriendRequestList(List val) {
    friendRequestList = val;
    update();
  }
  void removeFriends(int index){
    friendRequestList.removeAt(index);
    update();
  }

  ///Invited Friends
  Future<bool> checkInviteStatus(id) async {
    print("ffff $id");
    var headers = {'Content-Type': 'application/json'};
    var url = 'http://182.156.200.177:8011/adhanapi/receivers/$id/';

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
print("URL:$url");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        updateInvitedFriendList = data;

         print("Dataaaaa$data");

        return data['invited'] == true;
      } else {
        print("Error checking invite status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }

  RxList invitedFriendList = [].obs;
  List<RegisteredUserDataModal> get getInvitedFriendList =>
      List<RegisteredUserDataModal>.from(
          invitedFriendList.map((element) =>
              RegisteredUserDataModal.fromJson(element)).toList());

  set updateInvitedFriendList(List val) {
    invitedFriendList.value = val;
    update();
  }


  ///Invite friends
  sendFriendRequest(RegisteredUserDataModal registeredData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var bodyy=json.encode({
      "receiver_id": registeredData.userId.toString(),
      "sender_id": userData.getUserData!.id.toString()
    });
    print("bodyy $bodyy");
    var request = http.Request('POST',
        Uri.parse('http://182.156.200.177:8011/adhanapi/send-friend-request/'));
    request.body = json.encode({
      "receiver_id": registeredData.userId.toString(),
      "sender_id": userData.getUserData!.id.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    print("daaaaaaaaaaa $data");
    if(response.statusCode==201) {
      Get.snackbar('Success',data['detail'],
        // Show the response data
        snackPosition: SnackPosition.BOTTOM,

      );
    }
    else
      {

        Get.snackbar('Alert!',data['detail'],
            snackPosition: SnackPosition.BOTTOM);

      }
      }
  ///ACCEPT REQUEST

  acceptFriendRequest(FriendRequestDataModal friendRequestData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(
        'http://182.156.200.177:8011/adhanapi/accept-friend-request/'));
    request.body = json.encode({
      "request_id": friendRequestData.id.toString(),
      "user_id": userData.getUserData!.id.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    print("fff $data");

    fetchFriendRequests();
  }


  ///DECLINE REQUEST
  declineRequest(FriendRequestDataModal friendRequestData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(
        'http://182.156.200.177:8011/adhanapi/reject-friend-request/'));
    request.body = json.encode({
      "user_id": userData.getUserData!.id.toString(),
      "request_id": friendRequestData.id.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    print("aaaaaaaaaa $data");
  }

  }
  ///////////////////

