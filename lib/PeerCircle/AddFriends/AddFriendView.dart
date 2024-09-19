import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendController.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

import 'AddFriendDataModal.dart';

class AddFriendView extends GetView<AddFriendController> {
  @override
  Widget build(BuildContext context) {
    final AddFriendController controller = Get.put(AddFriendController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Text('Invite friends',style: MyTextTheme.mediumBCD,),
      leading: InkWell(
        onTap: (){
          Get.back();
        },
          child: Icon(Icons.arrow_back_ios_new)),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildSearchBar(),
            buildSection(title: 'REQUESTS', list: controller.requests, actionLabel: 'Accept', action: controller.acceptRequest),
            buildSection(title: 'IN YOUR CONTACT LIST', list: controller.contacts, actionLabel: 'Invite', action: controller.invitePerson),
            buildSection(title: 'PEOPLE NEARBY', list: controller.nearbyPeople, actionLabel: 'Invite', action: controller.invitePerson),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search username...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget buildSection({required String title, required RxList<Person> list, required String actionLabel, required Function(Person) action}) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: MyTextTheme.greyNormal),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final person = list[index];
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: person.imageUrl != null ? AssetImage(person.imageUrl!) : null),
                  title: Text(person.name),
                  subtitle: Text(person.phoneNumber),
                   trailing:
                   //TextButton(
                  //   onPressed: () => action(person),
                  //   child: Text(actionLabel, style: TextStyle(color: AppColor.circleIndicator)),
                  // ),
                    Container(
                      height:40,

                      decoration: BoxDecoration(
                        color: AppColor.circleIndicator,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () =>
                          action(person),
                        child: Text(actionLabel, style: TextStyle(color: AppColor.white)),

                      ),
                    )
                ),
                if (index < list.length - 5) Divider(), // Add Divider between items, but not after the last item
              ],
            );
          },
        ),
        Divider(), // Add a Divider after the section
      ],
    ));
  }
}