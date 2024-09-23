
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Services/user_data.dart';
import 'AddFriends/AddFriendDataModal.dart';


class PeerController extends GetxController{
  var searchText = ''.obs;
  RxBool isLoading = true.obs;
  var friendsList=[].obs;
  UserData userData = UserData();


  void setSearchText(String value) {
    searchText.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    friendship();
  }

  friendship() async {
    var request = http.Request('GET', Uri.parse(
        'http://182.156.200.177:8011/adhanapi/friendships/?user_id=${userData.getUserData!.id.toString()}'));



    http.StreamedResponse response = await request.send();
    isLoading.value = false;
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      updateFriendRequestList = data['friendships'];
      print("object"+getFriendshipList.toString());
    }
    else {
      print(response.reasonPhrase);
    }
  }


  List friendshipList = [];

  List<Friendship> get getFriendshipList =>
      List<Friendship>.from(
          friendshipList.map((element) =>
              Friendship.fromJson(element)).toList());

  set updateFriendRequestList(List val) {
    friendshipList = val;
    update();
  }

  ///REMOVE FRIEND
  removeFriend(String friendId) async {
    print("friendId $friendId");
    print("myId ${userData.getUserData!.id}");
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('http://182.156.200.177:8011/adhanapi/remove_friend/'));
    request.body = json.encode({
      "user_id":userData.getUserData!.id.toString(),
      "friend_id": friendId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  }
