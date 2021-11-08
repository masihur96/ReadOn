import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicController extends GetxController {
  SharedPreferences? preferences;
  RxBool isPhone = true.obs;
  RxDouble size = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    iniatializeApp();
  }

  Future<void> iniatializeApp() async {
    preferences = await SharedPreferences.getInstance();
    isPhone(preferences!.getBool('isPhone')!);
    if (isPhone.value) {
      size(MediaQuery.of(Get.context!).size.width);
    } else {
      size(MediaQuery.of(Get.context!).size.height);
    }
    update();
    // ignore: avoid_print
    print('IsPhone: ${isPhone.value}');
    // ignore: avoid_print
    print('Size: ${size.value}');
    // ignore: avoid_print
    print("Data Initialized !!!");
  }
}
