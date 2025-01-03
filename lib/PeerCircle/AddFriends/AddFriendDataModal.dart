class Person {
  final String id;
  final String name;
  final String phoneNumber;
  final String? imageUrl;

  Person({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      imageUrl: json['image_url'],
    );
  }
}




class RegisteredUserDataModal {
  int? userId;
  String? username;
  String? name;
  String? email;
  String? mobileNo;
  int? gender;
  int? fiqh;
  int? timesOfPrayer;
  int? schoolOfThought;
  int? methodId;
  String? methodName;
  String? picture;

  RegisteredUserDataModal(
      {this.userId,
        this.username,
        this.name,
        this.email,
        this.mobileNo,
        this.gender,
        this.fiqh,
        this.timesOfPrayer,
        this.schoolOfThought,
        this.methodId,
        this.methodName,
        this.picture});

  RegisteredUserDataModal.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    gender = json['gender'];
    fiqh = json['fiqh'];
    timesOfPrayer = json['times_of_prayer'];
    schoolOfThought = json['school_of_thought'];
    methodId = json['method_id'];
    methodName = json['method_name'];
    picture =json["picture"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['name'] = name;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['gender'] = gender;
    data['fiqh'] = fiqh;
    data['times_of_prayer'] = timesOfPrayer;
    data['school_of_thought'] = schoolOfThought;
    data['method_id'] = methodId;
    data['method_name'] = methodName;
    data['picture'] = picture;
    return data;
  }
}


class FriendRequestDataModal {
  int? id;
  String? sender;
  String? name;
  String? email;
  String? mobileNo;
  String? gender;
  String? fiqh;
  String? timesOfPrayer;
  String? schoolOfThought;
  String? methodId;
  String? methodName;
  String? picture;
  String? createdAt;

  FriendRequestDataModal(
      {this.id,
        this.sender,
        this.name,
        this.email,
        this.mobileNo,
        this.gender,
        this.fiqh,
        this.timesOfPrayer,
        this.schoolOfThought,
        this.methodId,
        this.methodName,
        this.picture,
        this.createdAt});

  FriendRequestDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender']??"";
    name = json['name']??"";
    email = json['email']??"";
    mobileNo = json['mobile_no'];
    gender = (json['gender']??"").toString();
    fiqh = (json['fiqh']??"").toString();
    timesOfPrayer = (json['times_of_prayer']??"").toString();
    schoolOfThought = (json['school_of_thought']??"").toString();
    methodId = (json['method_id']??"").toString();
    methodName = json['method_name'];
    picture = json['picture'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender'] = this.sender;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['gender'] = this.gender;
    data['fiqh'] = this.fiqh;
    data['times_of_prayer'] = this.timesOfPrayer;
    data['school_of_thought'] = this.schoolOfThought;
    data['method_id'] = this.methodId;
    data['method_name'] = this.methodName;
    data['picture'] = this.picture;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class Friendship {
  final int friendshipId;
  final User user1;
  final User user2;
  final DateTime createdAt;

  Friendship({
    required this.friendshipId,
    required this.user1,
    required this.user2,
    required this.createdAt,
  });

  // Factory constructor to create a Friendship instance from JSON
  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      friendshipId: json['friendship_id'],
      user1: User.fromJson(json['user1']),
      user2: User.fromJson(json['user2']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Method to convert a Friendship instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'friendship_id': friendshipId,
      'user1': user1.toJson(),
      'user2': user2.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String name;
  final String? email;
  final String mobileNo;
  final int? gender;
  final int? fiqh;
  final int? timesOfPrayer;
  final int? schoolOfThought;
  final int? methodId;
  final String? methodName;
  final String? picture;

  User({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    required this.mobileNo,
    this.gender,
    this.fiqh,
    this.timesOfPrayer,
    this.schoolOfThought,
    this.methodId,
    this.methodName,
    this.picture,
  });

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      gender: json['gender'],
      fiqh: json['fiqh'],
      timesOfPrayer: json['times_of_prayer'],
      schoolOfThought: json['school_of_thought'],
      methodId: json['method_id'],
      methodName: json['method_name'],
      picture: json['picture'],
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'mobile_no': mobileNo,
      'gender': gender,
      'fiqh': fiqh,
      'times_of_prayer': timesOfPrayer,
      'school_of_thought': schoolOfThought,
      'method_id': methodId,
      'method_name': methodName,
      'picture': picture,
    };
  }
}

class NotificationDataModal {
  String? notificationId;
  String? userId;
  String? title;
  String? message;
  String? category;
  DateTime? createdAt;
  bool? readStatus;
  String? actionUrl;

  NotificationDataModal({
    this.notificationId,
    this.userId,
    this.title,
    this.message,
    this.category,
    this.createdAt,
    this.readStatus,
    this.actionUrl,
  });

  factory NotificationDataModal.fromJson(Map<String, dynamic> json) {
    return NotificationDataModal(
      notificationId: json['id'] as String?,
      userId: json['user_id'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      category: json['type'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      readStatus: json['is_read'] as bool?,
      actionUrl: json['sender_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': notificationId,
      'user_id': userId,
      'title': title,
      'message': message,
      'type': category,
      'created_at': createdAt?.toIso8601String(),
      'is_read': readStatus,
      'sender_image': actionUrl,
    };
  }
}
