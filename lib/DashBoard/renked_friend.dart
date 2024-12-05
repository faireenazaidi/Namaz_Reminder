import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        Row(
          children: [
           SvgPicture.asset("assets/Frame.svg",height: 20,),
            SizedBox(width: 5),
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
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)

                ),

                child: Stack(
                  children: [
                    // Highlighted progress bar for current user's position
                    if (rankedFriends.isNotEmpty)
                    Positioned(
                      left: getCurrentUserPercentagePosition(context) * MediaQuery.of(context).size.width,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(10),
                          ),
                          color: AppColor.circleIndicator,
                        ),
                         width: MediaQuery.of(context).size.width * getHighlightedBarWidth(context),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Display avatars of ranked friends
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rankedFriends.map((friend) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage:friend.picture!=null?NetworkImage('http://182.156.200.177:8011${friend.picture}') :NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: currentUserId == friend.id ? Colors.orange : Colors.orange,
                ),



                const SizedBox(height: 4),
                Text(
                  friend.name.split(' ')[0],
                  style: const TextStyle(
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
