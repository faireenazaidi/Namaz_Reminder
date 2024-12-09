import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/PeerCircle/AddFriends/AddFriendController.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import 'InviteFriendsController.dart';

class InviteView extends GetView<InviteController> {
  const InviteView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddFriendController addFriendController = Get.find<AddFriendController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Contacts', style: MyTextTheme.mediumBCD),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            color: AppColor.packageGray,
          ),
        ),
      ),
      body: Obx(
            () {
              final validContacts = controller.contacts.where((contact) {
                final hasName = contact.displayName?.isNotEmpty ?? false;
                final hasNumber = contact.phones?.isNotEmpty ?? false;
                final registeredNumbers = addFriendController.registeredUsers.map((user) => user.phoneNumber).whereType<String>();
                final isRegistered = contact.phones?.any((phone) =>
                    registeredNumbers.contains(phone.value)) ?? false;
                return (hasName || hasNumber) && !isRegistered;
              }).toList();


              if (validContacts.isEmpty) {
            return const Center(
              child: Text(
                "No contacts available to invite",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return validContacts.isEmpty
              ? const Center(child: Text("No valid contacts found"))
              :
          ListView.builder(
            itemCount: validContacts.length,
            itemBuilder: (context, index) {
              Contact contact = validContacts[index];
              return ListTile(
                title: Text(contact.displayName ?? "No Name"),
                subtitle: contact.phones?.isNotEmpty ?? false
                    ? Text(contact.phones!.first.value ?? "No Number")
                    : null,
                leading: CircleAvatar(
                  backgroundColor: AppColor.circleIndicator,
                  child: Text(
                    contact.initials(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    // Get.snackbar(
                    //   'Invite Sent',
                    //   'Invitation sent to ${contact.displayName ?? "this contact"}',
                    //   snackPosition: SnackPosition.BOTTOM,
                    // );
                  },
                  child:  Text(
                    'Invite',
                    style: MyTextTheme.mustardN.copyWith(fontWeight:FontWeight.normal),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}