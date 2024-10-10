
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Services/user_data.dart';
import 'AddFriends/AddFriendDataModal.dart';


class PeerController extends GetxController{
  var searchText = ''.obs;
  RxBool isLoading = true.obs;
  var friendsList=[].obs;
  var searchQuery = '';
  var filteredFriendsList = <Friendship>[].obs; // Filtered list for search results

  UserData userData = UserData();


  void setSearchText(String value) {
    searchText.value = value;
    filterFriends(); // Filter the friends list when search text changes
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
      var data = jsonDecode(await response.stream.bytesToString());
      updateFriendRequestList = data['friendships'];
      print("object"+data['friendships'].toString());
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
    filterFriends();
    update();
  }
  void filterFriends() {
    if (searchText.value.isEmpty) {
      filteredFriendsList.value = getFriendshipList; // Show all friends if search text is empty
    } else {
      filteredFriendsList.value = getFriendshipList.where((friend) {
        return friend.user2.name
            .toString()
            .toLowerCase()
            .contains(searchText.value.toLowerCase());
      }).toList();
    }
    update();
  }
  void removeFriends(int index){
    friendshipList.removeAt(index);
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
      "friend_id": friendId.toString()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("success");
    }
    else {
      print(response.reasonPhrase);
      print('jjjjjjjjjjjjjjjjj');
    }
  }

  }
