import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class RankDisplayWidget extends StatelessWidget {
//
//
//   const RankDisplayWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<RankedFriend> rankedFriends = [
//       RankedFriend(id: 53, name: 'Baqar Naqvi', totalScore: 85.29, percentage: 17.058),
//       RankedFriend(id: 4, name: 'Faheem', totalScore: 0.0, percentage: 0.0),
//       // Add other ranked friends...
//     ];
//     // Assuming current user has id 53
//     final int currentUserId = 53;
//
//     // Find the rank of the current user
//     int userRank = rankedFriends.indexWhere((friend) => friend.id == currentUserId) + 1;
//
//     // Calculate total peers
//     int totalPeers = rankedFriends.length;
//
//     // Calculate the progress based on rank
//     double progressValue = userRank / totalPeers;
//
//     return Stack(
//       children: [
//         // Base Progress Bar
//         Container(
//           height: 20,
//           child: LinearProgressIndicator(
//             value: 17.058/100, // Progress bar at full length (for the background)
//             backgroundColor: Colors.grey[300],
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
//           ),
//         ),
//         // Overlay the names on top of the progress bar
//         Positioned.fill(
//           child: Row(
//             children: rankedFriends.map((friend) {
//               // Position each friend according to their percentage
//               return Expanded(
//                 flex: friend.percentage.toInt(), // Use percentage for dynamic positioning
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Column(
//                     children: [
//                       Text(
//                         friend.name,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       CircleAvatar(
//                         radius: 16,
//                         backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder for the friend's image
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
// class RankedFriend {
//   final int id;
//   final String name;
//   final double totalScore;
//   final double percentage;
//
//   RankedFriend({
//     required this.id,
//     required this.name,
//     required this.totalScore,
//     required this.percentage,
//   });
//
//   factory RankedFriend.fromJson(Map<String, dynamic> json) {
//     return RankedFriend(
//       id: json['id'],
//       name: json['name'],
//       totalScore: json['total_score'],
//       percentage: json['percentage'],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../Leaderboard/leaderboardDataModal.dart';
import '../Widget/appColor.dart';

class RankedFriendsIndicator extends StatelessWidget {
  final List<RankedFriend> rankedFriends;
  final int currentUserId; // The id of the current user to highlight

  const RankedFriendsIndicator({super.key,
    required this.rankedFriends,
    required this.currentUserId,
  });
  String getOrdinalIndicator(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display Rank Information
        // Row(
        //   children: [
        //     Text(
        //       '${getCurrentUserRank()}',
        //       style: const TextStyle(
        //         fontSize: 24,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     const SizedBox(width: 4),
        //     Text('Out of ${rankedFriends.length} person in peers'),
        //   ],
        // ),
        Row(
          children: [
            Text.rich(
              TextSpan(
                text: '${getCurrentUserRank()}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: getOrdinalIndicator(getCurrentUserRank()),
                    style: const TextStyle(
                      fontSize: 14,
                      textBaseline: TextBaseline.alphabetic,

                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Text('Out of ${rankedFriends.length} person in peers'),
          ],
        ),

        SizedBox(height: 16),

        // Display Ranking Bar
        Row(
          children: [
            // Grey bar to represent the background
            Expanded(
              child: Container(
                height: 6,
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    // Highlighted progress bar for current user's position
                    if (rankedFriends.isNotEmpty)
                    Positioned(
                      left: getCurrentUserPercentagePosition(context) * MediaQuery.of(context).size.width,
                      child: Container(
                        height: 6,
                        width: MediaQuery.of(context).size.width * getHighlightedBarWidth(context),
                        color: AppColor.circleIndicator,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Display avatars of ranked friends
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rankedFriends.map((friend) {
            return Column(
              children: [
                // CircleAvatar(
                //   radius: 18,
                //   backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with the friend's actual image
                //   backgroundColor: currentUserId == friend.id ? Colors.orange : Colors.transparent,
                // ),
                SizedBox(height: 4),
                Text(
                  friend.name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  // Function to get current user's rank position
  int getCurrentUserRank() {
    return rankedFriends.indexWhere((friend) => friend.id == currentUserId) + 1;
  }

  // Function to get percentage position of current user in the list
  double getCurrentUserPercentagePosition(BuildContext context) {
    int rank = getCurrentUserRank();
    print("this is rank $rank");
    return (rank - 1) / rankedFriends.length;
  }

  // Get the width of the highlighted bar (based on the current user's rank)
  double getHighlightedBarWidth(BuildContext context) {
    return 1 / rankedFriends.length;
  }
}
