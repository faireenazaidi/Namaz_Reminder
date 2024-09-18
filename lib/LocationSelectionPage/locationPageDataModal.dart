import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsDataModal {
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final bool isEmailVerified;
  final bool isAnonymous;
  final DateTime creationTime;
  final DateTime? lastSignInTime;
  final String? photoURL;

  UserDetailsDataModal({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.creationTime,
    this.lastSignInTime,
    this.photoURL,
  });

  // Create a UserDetails object from a Firebase User
  factory UserDetailsDataModal.fromFirebaseUser(User user) {
    return UserDetailsDataModal(
      uid: user.uid,
      displayName: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      isEmailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      creationTime: user.metadata.creationTime!,
      lastSignInTime: user.metadata.lastSignInTime,
      photoURL: user.photoURL,
    );
  }

  // Convert UserDetails to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'isEmailVerified': isEmailVerified,
      'isAnonymous': isAnonymous,
      'creationTime': creationTime.toIso8601String(),
      'lastSignInTime': lastSignInTime?.toIso8601String(),
      'photoURL': photoURL,
    };
  }

  // Create a UserDetails object from a JSON map
  factory UserDetailsDataModal.fromJson(Map<String, dynamic> json) {
    return UserDetailsDataModal(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isEmailVerified: json['isEmailVerified'],
      isAnonymous: json['isAnonymous'],
      creationTime: DateTime.parse(json['creationTime']),
      lastSignInTime: json['lastSignInTime'] != null
          ? DateTime.parse(json['lastSignInTime'])
          : null,
      photoURL: json['photoURL'],
    );
  }
}



class CalculationDataModal {
  String? key;
  int? id;
  String? name;
  int? isChecked;

  CalculationDataModal({this.key, this.id, this.name,this.isChecked});

  CalculationDataModal.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

