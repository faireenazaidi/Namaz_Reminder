import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:namaz_reminders/Leaderboard/prayer_ranking.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import '../DashBoard/dashboardController.dart';
import '../DashBoard/dashboardView.dart';
import 'leaderboardController.dart';
import 'leaderboardDataModal.dart';

class LeaderBoardView extends StatefulWidget {
  const LeaderBoardView({super.key});

  @override
  State<LeaderBoardView> createState() => _LeaderBoardViewState();
}

class _LeaderBoardViewState extends State<LeaderBoardView> {
  final DashBoardController dashboardController = Get.put(DashBoardController());
  final LeaderBoardController leaderBoardController = Get.put(LeaderBoardController());
  final DateController dateController = Get.put(DateController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      leaderBoardController.leaderboard(leaderBoardController.getFormattedDate());
      leaderBoardController.weeklyApi(leaderBoardController.getFormattedDate());
    });

  }
  @override
  Widget build(BuildContext context) {
    // Instantiate the DateController

    // final LeaderBoardController controller = Get.put(LeaderBoardController());

    return Scaffold(
      backgroundColor: AppColor.cream,
      body:
      CustomScrollView(
        slivers: [
          Obx(()=>SliverAppBar(
            title:  Text("Leaderboard",style: MyTextTheme.mediumBCD,),
            centerTitle: true,
            pinned: true,
             // expandedHeight:350,
            expandedHeight: leaderBoardController.selectedTab.value == 'Weekly' ? 350 : 250,
             // leaderBoardController.getSelectedTab == 'Daily'?Get.height/3.9:Get.height/2.6 ,

            backgroundColor: AppColor.cream,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
               InkWell(
                 onTap: (){
                   Get.to(
                         () => DashBoardView(),
                     transition: Transition.leftToRight,
                     duration: Duration(milliseconds: 500),
                     curve: Curves.ease,
                   );
                 },
                   child: Icon(Icons.arrow_back_ios_new, color: Colors.black,size: 20,)),


            ),

            flexibleSpace: FlexibleSpaceBar(

              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.all(16.0), // Adjust padding to avoid overflow
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70,),
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Daily Button
                        GestureDetector(
                          onTap: () =>
                          leaderBoardController.updateSelectedTab ='Daily',
                          child: Container(
                            decoration: BoxDecoration(
                              color: leaderBoardController.getSelectedTab == 'Daily' ? AppColor.circleIndicator : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              'Daily',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: leaderBoardController.selectedTab.value == 'Daily' ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Weekly Button
                        GestureDetector(
                          onTap: () => leaderBoardController.updateSelectedTab = 'Weekly',
                          child: Container(
                            decoration: BoxDecoration(
                              color: leaderBoardController.selectedTab.value == 'Weekly' ? AppColor.circleIndicator : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Text(
                              'Weekly',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: leaderBoardController.selectedTab.value == 'Weekly' ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(height: 20),
                    // leaderBoardController.selectedTab.value == 'Weekly'?MyDateTimeField(
                    //     borderColor: AppColor.cream,
                    //   hintText: leaderBoardController.selectedDate.value.toString().substring(0,10),
                    //   // controller: leaderBoardController.dateC,
                    //   // initialValue: leaderBoardController.selectedDate.value.toString().substring(0,10),
                    //   onChanged: (val){
                    //       if(val!=null){
                    //         leaderBoardController.weeklyApi(val.toString());
                    //         print("val $val");
                    //         print("val ${leaderBoardController.selectedDate.value.toString().substring(0,10)}");
                    //       }
                    //   },
                    //   //   decoration: InputDecoration(
                    //   //   fillColor: Colors.transparent,
                    //   // ),
                    //   ):
                    InkWell(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: dateController.selectedDate.value,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null) {
                          dateController.updateSelectedDate(picked);
                          String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
                          print("formattedDate $formattedDate");
                          leaderBoardController.weeklyApi(formattedDate.toString());
                          // leaderBoardController.leaderboard(formattedDate);
                        }
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/calendar3.svg",height: 15,),
                          const SizedBox(width: 5),
                          Obx(() => Row(
                            children: [
                              Text(
                                DateFormat('EEE,d MMMM yyyy').format(dateController.selectedDate.value),
                                style: const TextStyle(fontSize: 12, color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                width: 1, // Vertical divider width
                                height: 15, // Divider height
                                color: Colors.grey,
                                margin: const EdgeInsets.symmetric(horizontal: 10), // Adjust spacing between texts and divider
                              ),

                              Obx(
                                    () => Text(
                                  dashboardController.islamicDate.value,
                                  style: const TextStyle(fontSize: 12, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Expanded(
                              //   child: Text(
                              //     dateController.formatHijriDate(dateController.selectedDate.value),
                              //     style: const TextStyle(fontSize: 14, color: Colors.black),
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              // ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    if(leaderBoardController.selectedTab.value != 'Weekly')
                    Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("TODAY'S TIMELINE",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    )),
                    if(leaderBoardController.selectedTab.value == 'Weekly')
                      Obx(() {
                        return TopRankedUsers(rankedFriends: leaderBoardController.weeklyRanked.value,);
                      }
                    ),
                    SizedBox(height: 10,),

                    // Obx(()=>Visibility(
                    //   visible: leaderBoardController.selectedTab.value == 'Daily',
                    //   child:  Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       CircleAvatar(
                    //         radius: 20,
                    //         backgroundColor: AppColor.circleIndicator,
                    //         child: Text("F",style: MyTextTheme.mediumB,),
                    //       ),
                    //       CircleAvatar(
                    //         backgroundColor: AppColor.circleIndicator,
                    //         radius: 20,
                    //         child: Text("Z",style: MyTextTheme.mediumB,),
                    //       ),
                    //       CircleAvatar(
                    //         backgroundColor: AppColor.circleIndicator,
                    //         radius: 20,
                    //         child: Text("A",style: MyTextTheme.mediumB,),
                    //       ),
                    //       CircleAvatar(
                    //         backgroundColor: AppColor.circleIndicator,
                    //         radius: 20,
                    //         child: Text("M",style: MyTextTheme.mediumB,),
                    //       ),
                    //       CircleAvatar(
                    //         backgroundColor: AppColor.circleIndicator,
                    //         radius: 20,
                    //         child: Text("I",style: MyTextTheme.mediumB,),
                    //       )
                    //     ],
                    //   ),
                    // ),),
                    // if(leaderBoardController.selectedTab.value == 'Daily')
                    // DailyTopLeaderboard(records:leaderBoardController.getLeaderboardList.value!=null?
                    // leaderBoardController.getLeaderboardList.value!.records:[],
                    //   ranked: leaderBoardController.getLeaderboardList.value!=null?
                    //   leaderBoardController.getLeaderboardList.value!.rankedFriends:[],),
                    //
                    // Obx(()=>Visibility(
                    //   visible: controller.selectedTab.value == 'Weekly',
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       _buildTopUser("assets/bg.jpeg", "Abid Ali", "97%", 2),
                    //       _buildTopUser("assets/bg.jpeg", "Amira", "98.5%", 1),
                    //       _buildTopUser("assets/bg.jpeg", "Waleed Ahmed", "98%", 3),
                    //     ],
                    //   ),
                    // ),)
                  ],
                ),
              ),
            ),
          ),),





          SliverToBoxAdapter(
            child: Obx(() {
                return Visibility(
                  visible: leaderBoardController.selectedTab.value == 'Daily',
                  child: Container(
                    height: Get.height,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50.0),
                        ),
                      color: Colors.white
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                        width: 100,
                          height: 8  ,
                          decoration: BoxDecoration(
                            color:AppColor.packageGray,
                            borderRadius: BorderRadius.circular(10)
                          ),

                        ),
                        // ElevatedButton(onPressed: (){
                        //   Get.to(()=>PrayerRanking());
                        // }, child: Text('data'))
                        PrayerRanking(records:leaderBoardController.getLeaderboardList.value!=null?
                        leaderBoardController.getLeaderboardList.value!.records:[],
                          ranked: leaderBoardController.getLeaderboardList.value!=null?
                          leaderBoardController.getLeaderboardList.value!.rankedFriends:[],),

                         // Padding(
                         //   padding: const EdgeInsets.only(right: 8.0,top: 10),
                         //   child: Row(
                         //     crossAxisAlignment: CrossAxisAlignment.start,
                         //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         //    children: [
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            CircleAvatar(
                         //              radius: 20,
                         //              backgroundColor: AppColor.circleIndicator,
                         //              child: Text("F"),
                         //            ),
                         //
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount:leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.records.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Visibility(
                         //                  visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Fajr",
                         //                  child: Padding(
                         //                    padding: const EdgeInsets.all(8.0),
                         //                    child: CircleAvatar(
                         //                      backgroundColor: Colors.red,
                         //                      child: Icon(Icons.person,color: Colors.white,),),
                         //                  ),
                         //                );
                         //
                         //              },),
                         //
                         //
                         //          ],
                         //        ),
                         //      ),
                         //
                         //
                         //
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            CircleAvatar(
                         //              radius: 20,
                         //              backgroundColor: AppColor.circleIndicator,
                         //              child: Text("Z"),
                         //            ),
                         //
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount: leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.records.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Visibility(
                         //                  visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Dhuhr",
                         //                  child: Padding(
                         //                    padding: const EdgeInsets.all(8.0),
                         //                    child: CircleAvatar(
                         //                      backgroundColor: Colors.orange,
                         //                      child: Icon(Icons.person,color: Colors.white,),),
                         //                  ),
                         //                );
                         //
                         //              },),
                         //
                         //          ],
                         //        ),
                         //      ),
                         //
                         //
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            CircleAvatar(
                         //              radius: 20,
                         //              backgroundColor: AppColor.circleIndicator,
                         //              child: Text("A"),
                         //            ),
                         //
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount: leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.records.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Visibility(
                         //                  visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Asr",
                         //                  child: Padding(
                         //                    padding: const EdgeInsets.all(8.0),
                         //                    child: CircleAvatar(
                         //                      radius: 20,
                         //                      backgroundColor: Colors.transparent,
                         //                      child: Image.network("https://5.imimg.com/data5/SELLER/Default/2023/11/363042627/BL/GC/VA/141770070/ya-ali-islamic-wall-decor-metal-arts-for-muslim-homes-wall-hangings-islamic-calligraphy-islamic-gifts-500x500.jpg",scale: 6,),),
                         //                  ),
                         //                );
                         //
                         //              },),
                         //          ],
                         //        ),
                         //
                         //
                         //
                         //      ),
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            CircleAvatar(
                         //              radius: 20,
                         //              backgroundColor: AppColor.circleIndicator,
                         //              child: Text("M"),
                         //            ),
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount: leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.records.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Visibility(
                         //                  visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Maghrib",
                         //                  child: Padding(
                         //                    padding: const EdgeInsets.all(8.0),
                         //                    child: CircleAvatar(
                         //                      radius: 20,
                         //                      backgroundColor: Colors.transparent,
                         //                      child: Image.network("https://st.depositphotos.com/1057689/4949/i/450/depositphotos_49490713-stock-photo-islamic-symbol.jpg",scale: 6,),),
                         //                  ),
                         //                );
                         //
                         //              },),
                         //          ],
                         //        ),
                         //      ),
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            CircleAvatar(
                         //              radius: 20,
                         //              backgroundColor: AppColor.circleIndicator,
                         //              child: Text("I"),
                         //            ),
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount: leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.records.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Visibility(
                         //                  visible: leaderBoardController.getLeaderboardList.value!.records[index].prayerName == "Isha",
                         //                  child: Padding(
                         //                    padding: const EdgeInsets.all(8.0),
                         //                    child: CircleAvatar(
                         //                      radius: 22,
                         //                      backgroundColor: Colors.transparent,
                         //                      child: Image.network("https://www.auromin.in/cdn/shop/products/Untitled-1_ee823ade-f1f3-4b60-9665-865f453b7f16_600x.jpg?v=1664521813",scale: 6,),),
                         //                  ),
                         //                );
                         //
                         //              },)
                         //          ],
                         //        ),
                         //      ),
                         //      Expanded(
                         //        child: Column(
                         //          children: [
                         //            Padding(
                         //              padding: const EdgeInsets.all(8.0),
                         //              child: Text("Overall",style: MyTextTheme.mediumBCb.copyWith(color: Colors.black,fontWeight: FontWeight.bold),),
                         //            ),
                         //
                         //            ListView.builder(
                         //              physics: const NeverScrollableScrollPhysics(),
                         //              shrinkWrap: true,
                         //              itemCount: leaderBoardController.getLeaderboardList.value!=null? leaderBoardController.getLeaderboardList.value!.rankedFriends.length:0,
                         //              itemBuilder: (context, index) {
                         //                return Padding(
                         //                  padding: const EdgeInsets.only(bottom: 8,top: 12),
                         //                  child: CircleAvatar(
                         //                    radius: 20,
                         //                    backgroundColor: Colors.orangeAccent,
                         //                    child: Icon(Icons.person,color: Colors.white,)),
                         //                );
                         //
                         //              },)
                         //
                         //
                         //          ],
                         //        ),
                         //      )
                         //    ],
                         //                         ),
                         // ),

                      ]
                    ),
                  )
                );
                          },),
                      ),

          Obx(()=>SliverToBoxAdapter(
            child: Visibility(
                visible: leaderBoardController.selectedTab.value == 'Weekly',
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50.0),
                      ),
                      color: Colors.white
                  ),
                  child: ListView.builder(itemCount: leaderBoardController.weeklyRanked.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      bool isFound =  leaderBoardController.weeklyRanked[index]['id'].toString()==leaderBoardController.userData.getUserData!.id;
                    return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: _buildRankCard(leaderBoardController.weeklyRanked[index],index,isFound),
                      );}),
                ),
            ),
          ))

        ],
      ));

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.star, size: 35, color: Colors.grey),
            Positioned(
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
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



}


class RankingUI extends StatelessWidget {
  final List rankedFriends;
  // final List rankedFriends = [
  //   {
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 8.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 25.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 50.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 75.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 90.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 95.39
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 100.00
  //   },{
  //     "id": 53,
  //     "username": "303",
  //     "name": "Baqar Naqvi",
  //     "mobile_no": "7784928303",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 7,
  //     "method_id": 7,
  //     "method_name": "Institute of Geophysics, University of Tehran",
  //     "picture": null,
  //     "total_score": 293.62,
  //     "percentage": 0.0
  //   },
  //   {
  //     "id": 6,
  //     "username": "447",
  //     "name": "Baqar",
  //     "mobile_no": "7905216447",
  //     "gender": 0,
  //     "fiqh": 0,
  //     "times_of_prayer": 3,
  //     "school_of_thought": 4,
  //     "method_id": 4,
  //     "method_name": "Umm Al-Qura University, Makkah",
  //     "picture": null,
  //     "total_score": 65.79,
  //     "percentage": 1.88
  //   }
  // ];

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
  // final List rankedFriends = [
  //   {
  //     "id": 53,
  //     "name": "Baqar Naqvi",
  //     "picture": null,
  //     "percentage": 8.389142857142858
  //   },
  //   {
  //     "id": 6,
  //     "name": "Baqar",
  //     "picture": "/media/image_cropper_1726755884067.jpg",
  //     "percentage": 1.879714285714286
  //   },
  //   {
  //     "id": 15,
  //     "name": "John",
  //     "picture": "/media/image_cropper_1726755884067.jpg",
  //     "percentage": 10.879714285714286
  //   },
  // ];

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
                angle: -0.1,
                child: _buildRankCard(rankedFriends[2], 3, Colors.orange),
              ),
            if (rankedFriends.length > 2) const SizedBox(width: 16),
            if (rankedFriends.isNotEmpty)
              _buildRankCard(rankedFriends[0], 1, Colors.yellow),
            if (rankedFriends.length > 1) const SizedBox(width: 16),
            if (rankedFriends.length > 1)
              Transform.rotate(
                angle: 0.1,
                child: _buildRankCard(rankedFriends[1], 2, Colors.grey),
              ),
          ],
        ),
      );
  }

  Widget _buildRankCard(Map friend, int rank, Color badgeColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 5,),
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.star, size: 40, color: badgeColor),
            Positioned(
              child: Text(
                '$rank', // Display the rank number
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(1), // Padding around the square image
          decoration: BoxDecoration(
            shape: BoxShape.rectangle, // Change to rectangle for a square shape
            border: Border.all(color: Colors.yellow), // Yellow border
            borderRadius: BorderRadius.circular(8), // Optional: Adds rounded corners
          ),
          child: friend['picture'] != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(8), // Optional: Rounded corners for the image
            child: Image.network(
              "http://182.156.200.177:8011${friend['picture']}", // Replace with your image URL
              width: 50, // Set width for the square image
              height: 50, // Set height for the square image
              fit: BoxFit.cover, // Crop the image to fit
            ),
          )
              : const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.person,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ),
        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     Icon(Icons.star, size: 40, color: badgeColor),
        //     Positioned(
        //       child: Text(
        //         '$rank', // Display the rank number
        //         style: const TextStyle(
        //             color: Colors.white, fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   ],
        // ),
        // Container(
        //   width: 80,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: badgeColor, width: 3),
        //   ),
        //   child: friend['picture'] != null
        //       ? Image.network(
        //     "http://182.156.200.177:8011${friend['picture']}",
        //     width: 100,
        //     height: 50,
        //     fit: BoxFit.cover,
        //   )
        //       : Container(
        //     width: 100,
        //     height: 50,
        //     color: Colors.grey[300],
        //     child: Icon(Icons.person, size: 40, color: Colors.white),
        //   ),
        // ),
        SizedBox(height: 8),
        Text(
          friend['name'].split(' ')[0],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          '${friend['percentage'].toStringAsFixed(2)}%',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}


