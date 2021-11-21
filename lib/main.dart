import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:get/get.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /// Set Device orientation
  final bool _isPhone = Device.get().isPhone;
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(_isPhone) {CColor.portraitMood;}
  else {CColor.landscapeMood;}
  pref.setBool('isPhone', _isPhone);
  String? userAccessToken = pref.getString('userAccessToken');

  runApp(MyApp(userAccessToken: userAccessToken));
}

class MyApp extends StatelessWidget {
  String? userAccessToken;
  MyApp({Key? key, required this.userAccessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ReadON',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: const MaterialColor(0xffCC0027, CColor.themeColorMap),
          textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.red),
        canvasColor: Colors.transparent
      ),
      home: SplashScreen(userAccessToken: userAccessToken),
    );
  }
}
