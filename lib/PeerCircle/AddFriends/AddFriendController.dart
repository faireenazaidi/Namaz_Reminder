import 'dart:convert';
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
  var searchQuery = ''.obs;





  UserData userData = UserData();


  @override
  void onInit() {
    super.onInit();
    fetchRegisteredUsers();
    fetchFriendRequests();
    // filteredUserList.value = getRegisteredUserList;
    checkInviteStatus(userData.getUserData!.id);

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
        print("555 " + data.toString());

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

  ///Invited Friends
  Future<bool> checkInviteStatus(id) async {
    print("ffff "+id.toString());
    var headers = {'Content-Type': 'application/json'};
    var url = 'http://182.156.200.177:8011/adhanapi/receivers/$id/';

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
print("URL:"+url.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        updateInvitedFriendList = data;

         print("Dataaaaa"+data.toString());

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
  // Future<bool> checkInviteStatus(int receiverId) async {
  //   print("Receiver ID: $receiverId");
  //   var headers = {'Content-Type': 'application/json'};
  //   var url = 'http://182.156.200.177:8011/adhanapi/receivers/$receiverId/';
  //
  //   try {
  //     var response = await http.get(Uri.parse(url), headers: headers);
  //
  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       print("Data received: $data");
  //       bool isInvited = data['invited'] == true;
  //       return isInvited;
  //     } else {
  //       print("Error checking invite status: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("An error occurred: $e");
  //     return false;
  //   }
  // }
  List invitedFriendList = [];
  List<RegisteredUserDataModal> get getInvitedFriendList =>
      List<RegisteredUserDataModal>.from(
          invitedFriendList.map((element) =>
              RegisteredUserDataModal.fromJson(element)).toList());

  set updateInvitedFriendList(List val) {
    invitedFriendList = val;
    update();
  }

   // Future<bool> checkInviteStatus(int receiverId) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var url = 'http://182.156.200.177:8011/adhanapi/receivers/$receiverId/';
  //
  //   var response = await http.get(Uri.parse(url), headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     isInvited.value = data['invited'] == true;
  //     return isInvited.value;
  //   } else {
  //     print("Error checking invite status: ${response.statusCode}");
  //     return false;
  //   }
  // }
  ///Invite friends
  sendFriendRequest(RegisteredUserDataModal registeredData) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://182.156.200.177:8011/adhanapi/send-friend-request/'));
    request.body = json.encode({
      "receiver_id": registeredData.userId.toString(),
      "sender_id": userData.getUserData!.id.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    print("  " + data.toString());
    if(response.statusCode==200){
    Get.snackbar('Success', data['detail'].toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
    else
      {
        Get.snackbar('Error','Failed to sent friend request',
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
    print("fff " + data.toString());
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
    print("aaaaaaaaaa " + data.toString());
  }

  }
  ///////////////////






