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