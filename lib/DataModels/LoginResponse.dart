class PersonModel {
  int? responseCode;
  ResponseData? responseData;

  PersonModel({this.responseCode, this.responseData});

  PersonModel.fromJson(Map json) {
    responseCode = json['response_code'];
    responseData = json['response_data'] != null
        ? ResponseData.fromJson(json['response_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    if (responseData != null) {
      data['response_data'] = responseData!.toJson();
    }
    return data;
  }
}

class ResponseData {
  String? detail;
  User? user;

  ResponseData({this.detail, this.user});

  ResponseData.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  Null? email;
  String? mobileNo;
  String? name;
  int? gender;
  int? fiqh;
  int? timesOfPrayer;
  int? schoolOfThought;

  User(
      {this.id,
        this.username,
        this.email,
        this.mobileNo,
        this.name,
        this.gender,
        this.fiqh,
        this.timesOfPrayer,
        this.schoolOfThought});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    name = json['name'];
    gender = json['gender'];
    fiqh = json['fiqh'];
    timesOfPrayer = json['times_of_prayer'];
    schoolOfThought = json['school_of_thought'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['mobile_no'] = mobileNo;
    data['name'] = name;
    data['gender'] = gender;
    data['fiqh'] = fiqh;
    data['times_of_prayer'] = timesOfPrayer;
    data['school_of_thought'] = schoolOfThought;
    return data;
  }
}


class UserModel {
  String id;
  String username;
  String email;
  String mobileNo;
  String name;
  String gender;
  String fiqh;
  String timesOfPrayer;
  String schoolOfThought;
  String methodId;
  String methodName;
  String picture;
  String? preNamazAlert;
  bool? pauseAll;
  bool? quitMode;
  bool? friendRequest;
  bool? friendPrayed;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.mobileNo,
    required this.name,
    required this.gender,
    required this.fiqh,
    required this.timesOfPrayer,
    required this.schoolOfThought,
    required this.methodId,
    required this.methodName,
    required this.picture,
     this.preNamazAlert,
     this.pauseAll,
     this.quitMode,
     this.friendRequest,
     this.friendPrayed,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      username: (json['username']??'').toString(),
      email: (json['email']??'').toString(),
      mobileNo: (json['mobile_no']??'').toString(),
      name: (json['name']??'').toString(),
      gender: (json['gender']??'').toString(),
      fiqh: (json['fiqh']??'').toString(),
      timesOfPrayer: (json['times_of_prayer']??'').toString(),
      schoolOfThought: (json['school_of_thought']??'').toString(),
      methodId: (json['method_id']??'').toString(),
      methodName: (json['method_name']??'').toString(),
      picture: (json['picture']??'').toString(),
      preNamazAlert: (json['preNamazAlert']??'').toString(),
      pauseAll: (json['notification_off']??false).toString()=='true'?true:false,
      quitMode: (json['quiet_mode']??false).toString()=='true'?true:false,
      friendRequest: (json['fr_noti']??false).toString()=='true'?true:false,
      friendPrayed: (json['fn_mark_noti']??false).toString()=='true'?true:false,
    );
  }

  // Method to convert UserModel to a map (JSON)
  Map<String, String> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'mobile_no': mobileNo,
      'name': name,
      'gender': gender,
      'fiqh': fiqh,
      'times_of_prayer': timesOfPrayer,
      'method_id': methodId,
      'method_name': methodName,
      'picture': picture,
      'preNamazAlert': preNamazAlert!,
      'notification_off': pauseAll.toString(),
      'quitMode': quitMode.toString(),
      'fr_noti': friendRequest.toString(),
      'fn_mark_noti': friendPrayed.toString(),
    };
  }
}

class LocationDataModel {
  final String? latitude;
  final String? longitude;
  final String? address;

  LocationDataModel({
    this.latitude,
    this.longitude,
    this.address,
  });

  // Factory constructor to create LocationDataModel object from a JSON map
  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }

  // Method to convert LocationDataModel object to JSON map
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'LocationDataModel(latitude: $latitude, longitude: $longitude, address: $address)';
  }
}

