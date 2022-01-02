import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:read_on/model/division_bd_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PublicController extends GetxController {
  SharedPreferences? preferences;
  RxBool isPhone = true.obs;
  RxDouble size = 0.0.obs;
  String deviceId = '';
  Rx<DivisionBdModel> divisionModel = DivisionBdModel().obs;

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

  Future<void> getMacAddress() async {
    try {
      deviceId = (await PlatformDeviceId.getDeviceId)!;
    } on PlatformException {
      // ignore: avoid_print
      print('Failed to get deviceId.');
    }
  }

  Future <void> getDivisionList() async {
    const baseUrl = "https://bdapis.herokuapp.com/api/v1.1/divisions";
    try{
      http.Response response = await http.get(Uri.parse(baseUrl));
      divisionModel.value = divisionBdModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print("Getting division list error: $error");
    }
  }
}
