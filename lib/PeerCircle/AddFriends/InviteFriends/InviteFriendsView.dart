import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../Widget/appColor.dart';
import '../../../Widget/text_theme.dart';
import '../AddFriendController.dart';
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
          final registeredNumbers = addFriendController.registeredUsers
              .map((user) => user.phoneNumber)
              .whereType<String>()
              .toSet();

          final validContacts = controller.contacts.where((contact) {
            final hasName = contact.displayName?.isNotEmpty ?? false;
            final hasNumber = contact.phones?.isNotEmpty ?? false;
            final isRegistered = contact.phones?.any(
                  (phone) => registeredNumbers.contains(phone.value),
            ) ?? false;
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

          return ListView.builder(
            itemCount: validContacts.length,
            itemBuilder: (context, index) {
              Contact contact = validContacts[index];
              final phoneNumber = contact.phones?.isNotEmpty == true
                  ? contact.phones!.first.value!.replaceAll(RegExp(r'\s+'), '')
                  : "";

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
                    if (phoneNumber.isNotEmpty) {
                      final inviteMessage = "Hi ${contact.displayName ?? "Friend"}, join us on our amazing app! Here's the link: [Insert App Link]";
                      Share.share(inviteMessage);
                    } else {
                      Get.snackbar(
                        'Error',
                        'This contact does not have a valid phone number.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Text(
                    'Invite',
                    style: MyTextTheme.mustardN.copyWith(fontWeight: FontWeight.normal),
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
