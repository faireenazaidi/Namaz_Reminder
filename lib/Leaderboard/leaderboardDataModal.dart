import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class DateController extends GetxController {
  // Observable to hold the selected date
  var selectedDate = DateTime.now().obs;

  // Method to update the selected date
  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  // Method to format Hijri date
  String formatHijriDate(DateTime date) {
    final hijriDate = HijriCalendar.fromDate(date);
    final months = [
      'Muharram', 'Safar', 'Rabi\' al-awwal', 'Rabi\' al-thani', 'Jumada al-awwal', 'Jumada al-thani',
      'Rajab', 'Sha\'ban', 'Ramadan', 'Shawwal', 'Dhu al-Qi\'dah', 'Dhu al-Hijjah'
    ];
    return '${hijriDate.hDay} ${months[hijriDate.hMonth - 1]} ${hijriDate.hYear} AH';
  }
}
final avatarUrls = [
  'https://images.unsplash.com/photo-1506748686214e9df14f5b5d5d3c5a84a2fbd4da1dc1b5c',
  'ttps://images.unsplash.com/photo-1533802255692-f7c7f36e4f8d',
  'https://images.unsplash.com/photo-1534528741775-539d9b6e3d9d',
  'https://images.unsplash.com/photo-1547658710-b61ec1a9d1b0',
  'https://images.unsplash.com/photo-1495568825141-7485f9e43fc0',
  'https://images.unsplash.com/photo-1517964571684-1aeb5a9f6cce',
  'https://images.unsplash.com/photo-1506748686214-84c1e6f7e59e',
  'https://images.unsplash.com/photo-1534230213353-15c3a6dd09b2',
  'https://images.unsplash.com/photo-1549155461-15d1a2b58dc1',
  'https://images.unsplash.com/photo-1520818351590-f7006ae1248f',
  'https://images.unsplash.com/photo-1555685816-d79eec8b7518',
  'https://images.unsplash.com/photo-1533001859037-48f72e54c3ec',
  'https://images.unsplash.com/photo-1592194996308-7b43878e84a6',
  'https://images.unsplash.com/photo-1574158622683-1f7b7ecb3f08',
  'https://images.unsplash.com/photo-1521369106474-c3fd752fbf52',
  'https://images.unsplash.com/photo-1517889990740-5b3783b79485',
  'https://images.unsplash.com/photo-1565575451-16bfc023f6b7',
  'https://images.unsplash.com/photo-1583788509587-b7677dd1d2f4',
  'https://images.unsplash.com/photo-1555685816-d79eec8b7518',
  'https://images.unsplash.com/photo-1549188710-e40538e87238',
  'https://images.unsplash.com/photo-1564736892-d62b4b0c6b0d',
  'https://images.unsplash.com/photo-1569180878-e2186ac9e0cb',
  'https://images.unsplash.com/photo-1564694208-c43f85eebed2',
  'https://images.unsplash.com/photo-1569180758-2d717c89d5c6',
  'https://images.unsplash.com/photo-1566944924-4d7ec4ae2581',
  'https://images.unsplash.com/photo-1534530149783-3bb4ad909ac9',
];
//
//
//
// class LeaderboardDataModal {
//   User? user;
//   String? userTimestamp;
//   double? latitude;
//   double? longitude;
//   String? date;
//   String? prayerName;
//   double? score;
//   bool? jamat;
//   int? timesOfPrayer;
//
//   LeaderboardDataModal(
//       {this.user,
//         this.userTimestamp,
//         this.latitude,
//         this.longitude,
//         this.date,
//         this.prayerName,
//         this.score,
//         this.jamat,
//         this.timesOfPrayer});
//
//   LeaderboardDataModal.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     userTimestamp = json['user_timestamp'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     date = json['date'];
//     prayerName = json['prayer_name'];
//     score = json['score'];
//     jamat = json['jamat'];
//     timesOfPrayer = json['times_of_prayer'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['user_timestamp'] = this.userTimestamp;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['date'] = this.date;
//     data['prayer_name'] = this.prayerName;
//     data['score'] = this.score;
//     data['jamat'] = this.jamat;
//     data['times_of_prayer'] = this.timesOfPrayer;
//     return data;
//   }
// }
//
// class User {
//   int? id;
//   String? username;
//   String? mobileNo;
//
//   User({this.id, this.username, this.mobileNo});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     mobileNo = json['mobile_no'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['mobile_no'] = this.mobileNo;
//     return data;
//   }
// }
//
// class RankedDataModel {
//   final int id;
//   final String name;
//   final double totalScore;
//   final double percentage;
//
//   RankedDataModel({
//     required this.id,
//     required this.name,
//     required this.totalScore,
//     required this.percentage,
//   });
//
//   // Factory constructor to create LeaderboardDataModal from JSON
//   factory RankedDataModel.fromJson(Map<String, dynamic> json) {
//     return RankedDataModel(
//       id: json['id'],
//       name: json['name'],
//       totalScore: json['total_score'],
//       percentage: json['percentage'],
//     );
//   }
//
//   // Method to convert LeaderboardDataModal object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'total_score': totalScore,
//       'percentage': percentage,
//     };
//   }
// }
//
class LeaderboardDataModal {
  final User user;
  final List<Record> records;
  final List<RankedFriend> rankedFriends;

  LeaderboardDataModal({
    required this.user,
    required this.records,
    required this.rankedFriends,
  });

  // Factory constructor to create LeaderboardDataModal from JSON
  factory LeaderboardDataModal.fromJson(Map<String, dynamic> json) {
    return LeaderboardDataModal(
      user: User.fromJson(json['user']),
      records: json['records'] != null
          ? List<Record>.from(json['records'].map((record) => Record.fromJson(record)))
          : [], // Provide an empty list if records is null
      rankedFriends: json['ranked_friends'] != null
          ? List<RankedFriend>.from(json['ranked_friends'].map((friend) => RankedFriend.fromJson(friend)))
          : [], // Provide an empty list if ranked_friends is null
    );
  }

  // Method to convert LeaderboardDataModal object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'records': records.map((record) => record.toJson()).toList(),
      'ranked_friends': rankedFriends.map((friend) => friend.toJson()).toList(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String mobileNo;

  User({
    required this.id,
    required this.username,
    required this.mobileNo,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      mobileNo: json['mobile_no'],
    );
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'mobile_no': mobileNo,
    };
  }
}

class Record {
  final User user;
  final String? userTimestamp;
  final double latitude;
  final double longitude;
  final String date;
  final String prayerName;
  final String score;
  final bool jamat;
  final int timesOfPrayer;

  Record({
    required this.user,
    required this.userTimestamp,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.prayerName,
    required this.score,
    required this.jamat,
    required this.timesOfPrayer,
  });

  // Factory constructor to create Record from JSON
  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      user: User.fromJson(json['user']),
      userTimestamp: json['user_timestamp'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      date: json['date'],
      prayerName: json['prayer_name'],
      score: json['score'].toString(),
      jamat: json['jamat'],
      timesOfPrayer: json['times_of_prayer'],
    );
  }

  // Method to convert Record object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'user_timestamp': userTimestamp,
      'latitude': latitude,
      'longitude': longitude,
      'date': date,
      'prayer_name': prayerName,
      'score': score,
      'jamat': jamat,
      'times_of_prayer': timesOfPrayer,
    };
  }
}

class RankedFriend {
  final int id;
  final String name;
  final double totalScore;
  final double percentage;

  RankedFriend({
    required this.id,
    required this.name,
    required this.totalScore,
    required this.percentage,
  });

  // Factory constructor to create RankedFriend from JSON
  factory RankedFriend.fromJson(Map<String, dynamic> json) {
    return RankedFriend(
      id: json['id'],
      name: json['name'],
      totalScore: json['total_score'],
      percentage: json['percentage'],
    );
  }

  // Method to convert RankedFriend object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'total_score': totalScore,
      'percentage': percentage,
    };
  }
}
