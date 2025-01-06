import 'dart:ui';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class InviteController extends GetxController {
  var contacts = <Contact>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      Iterable<Contact> deviceContacts = await ContactsService.getContacts();
      contacts.value = deviceContacts.toList();
    } else if (status.isDenied) {
      var result = await Permission.contacts.request();
      if (result.isGranted) {
        Iterable<Contact> deviceContacts = await ContactsService.getContacts();
        contacts.value = deviceContacts.toList();
      } else {
        Get.snackbar(
          'Permission Denied',
          'You denied the permission. Please enable contact access in settings.',
          snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
          colorText: Colors.white
        );
      }
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        'Permission Required',
        'Please enable contact access in your device settings.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
          colorText: Colors.white
      );
      await openAppSettings();
    }
  }
}