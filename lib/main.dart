import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:get/get.dart';
import 'package:read_on/eBook/reading_screen.dart/mina_reader.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  MinaReader.initReader();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  /// Set Device orientation
  final bool _isPhone = Device.get().isPhone;
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (_isPhone) {
    CColor.portraitMood;
  } else {
    CColor.landscapeMood;
  }
  pref.setBool('isPhone', _isPhone);
  String? readOnUserId = pref.getString('readOnUserId');

  runApp(ProviderScope(child: MyApp(readOnUserId: readOnUserId)));
}

class MyApp extends StatelessWidget {
  String? readOnUserId;
  MyApp({Key? key, required this.readOnUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ReadON',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: const MaterialColor(0xffCC0027, CColor.themeColorMap),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.red),
          canvasColor: Colors.transparent),
      home: SplashScreen(readOnUserId: readOnUserId),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
