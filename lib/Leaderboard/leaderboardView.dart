import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Leaderboard/prayer_ranking.dart';
import 'package:namaz_reminders/Missed%20Prayers/missed_prayers_controller.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../DashBoard/dashboardController.dart';
import 'LeaderBoardController.dart';
import 'leaderboardDataModal.dart';

class LeaderBoardView extends StatefulWidget {
  const LeaderBoardView({super.key});

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  final DashBoardController dashboardController = Get.put(
      DashBoardController());
  final LeaderBoardController leaderBoardController = Get.put(
      LeaderBoardController());
  final DateController dateController = Get.put(DateController());
  final MissedPrayersController missedPrayersController = Get.put(MissedPrayersController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leaderBoardController.leaderboard(
          leaderBoardController.getFormattedDate());
      leaderBoardController.weeklyApi(leaderBoardController.getFormattedDate());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColor.cream,
        body:
          CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            // physics: leaderBoardController.selectedTab.value == 'Weekly'
            //     ? NeverScrollableScrollPhysics()
            //     : NeverScrollableScrollPhysics(),
            slivers: [
              Obx(() =>
                  SliverAppBar(
                    title: Text(
                      "Leaderboard",
                      style: MyTextTheme.mediumBCD,
                    ),
                    centerTitle: true,
                    pinned: true,
                    expandedHeight: leaderBoardController.selectedTab.value ==
                        'Weekly' ? 350 : 200,
                    backgroundColor: AppColor.cream,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background Image
                          SvgPicture.asset(
                              "assets/jali.svg",
                              fit: BoxFit.cover,
                              color: AppColor.greyDark
                          ),
                          // Adding Padding and other widgets over the background image
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            // Adjust padding as needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 70),
                                Obx(() =>
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        // Daily Button
                                        GestureDetector(
                                          onTap: () {
                                            leaderBoardController
                                                .updateSelectedDate(
                                                DateTime.now());
                                            leaderBoardController
                                                .updateSelectedTab = 'Daily';
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: leaderBoardController
                                                  .getSelectedTab == 'Daily'
                                                  ? Colors.white60
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  20),
                                            ),
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 4,
                                                  width: 28,
                                                  decoration: BoxDecoration(
                                                      color: leaderBoardController
                                                          .selectedTab.value ==
                                                          'Daily'
                                                          ? AppColor
                                                          .circleIndicator
                                                          : Colors.transparent,
                                                      borderRadius: BorderRadius
                                                          .circular(5)
                                                  ),
                                                ),
                                                Text(
                                                  'Daily',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: leaderBoardController
                                                        .selectedTab.value ==
                                                        'Daily'
                                                        ? FontWeight.w500
                                                        : FontWeight.normal,
                                                    color: leaderBoardController
                                                        .selectedTab.value ==
                                                        'Daily'
                                                        ? Colors.black
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // Weekly Button
                                        GestureDetector(
                                          onTap: () {
                                            leaderBoardController
                                                .updateSelectedDate(
                                                DateTime.now());
                                            leaderBoardController
                                                .updateSelectedTab = 'Weekly';
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: leaderBoardController
                                                  .selectedTab.value == 'Weekly'
                                                  ? Colors.white60
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  20),
                                            ),

                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 4,
                                                  width: 28,
                                                  decoration: BoxDecoration(
                                                      color: leaderBoardController
                                                          .selectedTab.value ==
                                                          'Weekly'
                                                          ? AppColor
                                                          .circleIndicator
                                                          : Colors.transparent,
                                                      borderRadius: BorderRadius
                                                          .circular(5)
                                                  ),
                                                ),
                                                Text(
                                                  'Weekly',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: leaderBoardController
                                                        .selectedTab.value ==
                                                        'Daily'
                                                        ? FontWeight.normal
                                                        : FontWeight.w500,
                                                    color: leaderBoardController
                                                        .selectedTab.value ==
                                                        'Weekly'
                                                        ? Colors.black
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ),
                                      ],
                                    )),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: () async {
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: leaderBoardController
                                          .selectedDate.value,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      leaderBoardController.updateSelectedDate(
                                          picked);
                                      String formattedDate =
                                      DateFormat('dd-MM-yyyy').format(picked);
                                      leaderBoardController.weeklyApi(
                                          formattedDate.toString());
                                    }
                                  },
                                  //child:
                                  // Row(
                                  //   children: [
                                  //     SvgPicture.asset(
                                  //         "assets/calendar3.svg", height: 15),
                                  //     const SizedBox(width: 5),
                                  //     Obx(() =>
                                  //         Row(
                                  //           children: [
                                  //             Text(
                                  //               DateFormat('EEE, d MMMM yyyy')
                                  //                   .format(
                                  //                   leaderBoardController
                                  //                       .selectedDate.value),
                                  //               style: const TextStyle(
                                  //                   fontSize: 12,
                                  //                   color: Colors.black),
                                  //               overflow: TextOverflow.ellipsis,
                                  //             ),
                                  //             Container(
                                  //               width: 1,
                                  //               height: 15,
                                  //               color: Colors.grey,
                                  //               margin: const EdgeInsets
                                  //                   .symmetric(
                                  //                   horizontal: 10),
                                  //             ),
                                  //             Obx(
                                  //                   () =>
                                  //                   Text(
                                  //                     leaderBoardController
                                  //                         .islamicDate.value,
                                  //                     style: const TextStyle(
                                  //                         fontSize: 12,
                                  //                         color: Colors.black),
                                  //                     overflow: TextOverflow
                                  //                         .ellipsis,
                                  //                   ),
                                  //             ),
                                  //           ],
                                  //         )),
                                  //   ],
                                  // ),
                                child:   Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/calendar3.svg", height: 15),
                                      const SizedBox(width: 5),
                                      Obx(() =>
                                      leaderBoardController
                                          .getSelectedTab == 'Daily'? Row(
                                        children: [
                                          Text(
                                            DateFormat('EEE, d MMMM yyyy').format(leaderBoardController.selectedDate.value),
                                            style: const TextStyle(fontSize: 12,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 15,
                                            color: Colors.grey,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                          ),
                                          Obx(() =>
                                              Text(
                                                leaderBoardController.islamicDate.value,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              )),
                                        ],
                                      ):
                                      Text(
                                        "${DateFormat('EEE, d MMMM yyyy').format(leaderBoardController.selectedDate.value)} - "
                                            "${DateFormat('EEE, d MMMM yyyy').format(leaderBoardController.selectedDate.value.subtract(Duration(days: 7)))}",
                                        style: const TextStyle(fontSize: 12,
                                            color: Colors.black),
                                      )
                                      )
                                    ],
                                  ),
                                ),
                                if (leaderBoardController.selectedTab.value !=
                                    'Weekly')
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                if (leaderBoardController.selectedTab.value ==
                                    'Weekly')
                                  Obx(() {
                                    return TopRankedUsers(
                                      rankedFriends: leaderBoardController
                                          .weeklyRanked.value,
                                    );
                                  }),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

              ///
              Obx(() {
                if (leaderBoardController.selectedTab.value == 'Daily') {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        height: Get.height * 0.75,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(50.0),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                width: 110,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColor.packageGray,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(height: 10),
                              // Removed Expanded and directly used the PrayerRanking widget
                              Expanded(
                                child: SingleChildScrollView(
                                  child: PrayerRanking(
                                    records: leaderBoardController
                                        .getLeaderboardList.value != null
                                        ? leaderBoardController
                                        .getLeaderboardList
                                        .value!.records
                                        : [],
                                    ranked: leaderBoardController
                                        .getLeaderboardList
                                        .value != null
                                        ? leaderBoardController
                                        .getLeaderboardList
                                        .value!.rankedFriends
                                        : [],
                                    id: leaderBoardController.userData
                                        .getUserData!
                                        .id.toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                }
                // else if (leaderBoardController.selectedTab.value == 'Weekly') {
                //   return SliverList(
                //     delegate: SliverChildListDelegate([
                //       Container(
                //         height: Get.height * 0.5,
                //         decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.vertical(
                //             top: Radius.circular(40.0),
                //           ),
                //           color: Colors.white,
                //         ),
                //         child: Stack(
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 SizedBox(height: 25),
                //                 Container(
                //                   width: 110,
                //                   height: 8,
                //                   decoration: BoxDecoration(
                //                     color: AppColor.packageGray,
                //                     borderRadius: BorderRadius.circular(10),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Positioned.fill(
                //               child: ListView.builder(
                //                 itemCount: leaderBoardController.weeklyRanked
                //                     .length,
                //                 shrinkWrap: true,
                //                 scrollDirection: Axis.horizontal,
                //                 itemBuilder: (context, index) {
                //                   bool isFound = leaderBoardController
                //                       .weeklyRanked[index]['id'].toString() ==
                //                       leaderBoardController.userData
                //                           .getUserData!
                //                           .id;
                //                   return Padding(
                //                     padding: const EdgeInsets.only(left: 10.0),
                //                     child: _buildRankCard(
                //                         leaderBoardController
                //                             .weeklyRanked[index],
                //                         index, isFound),
                //                   );
                //                 },
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ]),
                //   );
                // }
                else if (leaderBoardController.selectedTab.value == 'Weekly') {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      AspectRatio(
                        aspectRatio: 3/3.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              // Top indicator (small rounded rectangle)
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    width: 110,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColor.packageGray,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                bottom: Get.height*0.02,
                                left: 0.0,
                                right: 0.0,
                                child: ListView.builder(
                                  itemCount: leaderBoardController.weeklyRanked.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    bool isFound = leaderBoardController.weeklyRanked[index]
                                    ['id']
                                        .toString() ==
                                        leaderBoardController.userData.getUserData!.id;
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: _buildRankCard(
                                        leaderBoardController.weeklyRanked[index],
                                        index,
                                        isFound,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                }
                else {
                  return SliverToBoxAdapter(child: SizedBox.shrink());
                }
              })

            ],


        ));
  }

}



Widget _buildTopUser(String imageUrl, String name, String score, int rank) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(imageUrl),
          ),
          CircleAvatar(
            radius: 12,
            backgroundColor: rank == 1 ? Colors.orange : Colors.grey.shade400,
            child: Text(
              rank.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      const SizedBox(height: 5),
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(score, style:  TextStyle(color: AppColor.circleIndicator)),
    ],
  );
}


Widget _buildUserProgress(String imageUrl, String name, String score, {bool highlight = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20),
    child: Column(
      children: [
        const Icon(Icons.star,size: 40,),
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: highlight ? [AppColor.circleIndicator, Colors.yellow.shade50] : [Colors.grey.shade400,Colors.white12, ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.fill)
                ),
              ),
              const SizedBox(height: 5),
              Text(score, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
            width: 60,
            child: Text(name, style: const TextStyle())),
      ],
    ),
  );
}

Widget _buildRankCard(Map friend,int index,bool isHighlight) {
  double percentage = double.parse(friend['percentage'].toStringAsFixed(2));
  print("percentage $percentage");
  // double percentage = friend['percentage'];
// Determine the SVG asset based on the rank
  String rankSvg;
  switch (index) {
    case 0:
      rankSvg = 'assets/Gold.svg'; // for 1st rank
      break;
    case 1:
      rankSvg = 'assets/silver.svg'; // for 2nd rank
      break;
    case 2:
      rankSvg = 'assets/Bronze.svg'; // for 3rd rank
      break;
    default:
      rankSvg = 'assets/other.svg'; // Default  for other ranks
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          // SvgPicture.asset('assets/other.svg',height: 25,),
          SvgPicture.asset(rankSvg,height: 25,),
          Positioned(
            bottom: 5,
            child: Text(
              '${index+1}', // Display the rank number here
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 8),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Flexible(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeIn,
          height: percentage * 5 + 110, // Dynamic height based on percentage
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:isHighlight? [Colors.orange.shade200, Colors.yellow.shade50]:[Colors.grey.shade500, Colors.grey.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Remove ClipRRect to avoid circular border and allow rectangular image
              friend['picture'] != null
                  ? Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("http://182.156.200.177:8011${friend['picture']}"),
                    fit: BoxFit.cover, // This will ensure the image covers the entire container
                  ),
                  borderRadius: BorderRadius.circular(10), // Optional: to round the corners
                ),
              )
                  : Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: AppColor.packageGray,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:  Icon(Icons.person, color: AppColor.circleIndicator),
              ),
              const SizedBox(height: 15),
              Text(
                '$percentage%',
                style: TextStyle(fontSize: 12, fontWeight:isHighlight? FontWeight.w600:null),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 4),
      isHighlight?Text('You', style: MyTextTheme.mustardS) :Text(friend['name'].split(' ')[0], style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500)),
    ],
  );
}





class RankingUI extends StatelessWidget {
  final List rankedFriends;
  RankingUI({super.key, required this.rankedFriends});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end, // Aligns containers to the bottom
        children: rankedFriends.map((friend) {
          print("friend $friend");
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _buildRankCard(friend),
          );
        }).toList(),
      ),
    );

  }

  Widget _buildRankCard(Map friend) {
    double percentage = double.parse(friend['percentage'].toStringAsFixed(2));
    print("percentage $percentage");
    // double percentage = friend['percentage'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.star, size: 35, color: Colors.grey),
            Positioned(
              child: Text(
                '${friend['id']}', // Display the rank number here
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 8),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Flexible(
          child: AnimatedContainer(
            duration: Duration(seconds: 10),
            curve: Curves.easeIn,
            height: percentage * 5 + 110, // Dynamic height based on percentage
            width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade200, Colors.yellow.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Remove ClipRRect to avoid circular border and allow rectangular image
                friend['picture'] != null
                    ? Container(
                  width: 80,
                  height: 60,
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("http://182.156.200.177:8011${friend['picture']}"),
                      fit: BoxFit.cover, // This will ensure the image covers the entire container
                    ),
                    borderRadius: BorderRadius.circular(15), // Optional: to round the corners
                  ),
                )
                    : Container(
                  width: 80,
                  height: 60,
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  '$percentage%',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(friend['name'], style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class TopRankedUsers extends StatelessWidget {
  final List rankedFriends;
  const TopRankedUsers({super.key, required this.rankedFriends});
  @override
  Widget build(BuildContext context) {

    // Sort the list in descending order based on percentage
    if(rankedFriends.isNotEmpty){
      rankedFriends.sort((a, b) => b['percentage'].compareTo(a['percentage']));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (rankedFriends.length > 2)
            Transform.rotate(
              angle: -0.22,
              child: _buildRankCard(rankedFriends[2], 3, 'assets/3medal.svg'),
            ),
          if (rankedFriends.length > 2) const SizedBox(width: 18),
          if (rankedFriends.isNotEmpty)
            _buildRankCard(rankedFriends[0], 1,  'assets/1medal.svg',),
          if (rankedFriends.length > 1) const SizedBox(width: 18),
          if (rankedFriends.length > 1)
            Transform.rotate(
              angle: 0.22,
              child: _buildRankCard(rankedFriends[1], 2,  'assets/2medal.svg'),
            ),
        ],
      ),
    );
  }

  Widget _buildRankCard(Map friend, int rank, String svgPath) {
    double height = rank ==1? 90:80;
    double width = rank ==1? 90:80;
    double h = rank ==1? 15:35;
    Color clr = rank == 1 ? AppColor.amberColor : (rank==2)?Colors.blueGrey:Colors.deepOrangeAccent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: h),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,

                border: Border.all(color:clr,width:0.8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: friend['picture'] != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "http://182.156.200.177:8011${friend['picture']}",
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
              )
                  :  Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  color: AppColor.circleIndicator,
                  size: 30,
                ),
              ),
            ),

            Positioned(
              bottom: -18,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Icon(Icons.star, size: 40, color: badgeColor),
                  SvgPicture.asset(svgPath,height: 40,width: 40,),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),
        Text(
          friend['name'].split(' ')[0],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        Text(
          '${friend['percentage'].toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );


  }
}



