import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/quiz/quiz_widgets/quiz_drawer.dart';
import 'package:read_on/quiz/screens/academic/bottom_nav/quiz_home_nav.dart';
import 'package:read_on/quiz/screens/academic/bottom_nav/quiz_live_nav.dart';
import 'package:read_on/quiz/screens/academic/bottom_nav/quiz_menu_nav.dart';
import 'package:read_on/quiz/screens/academic/bottom_nav/quiz_profile_nav.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({Key? key}) : super(key: key);

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        bottomNavigationBar: _pageBottomNavigationBar(),
        body: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: QuizCustomDrawer()),
          body: _bodyUI(publicController),
        )
      ),
    );
  }

  /// page body
  Widget _bodyUI(PublicController publicController) => _navBarIndex == 0
      ?  const QuizHomeNav()
      : _navBarIndex == 1
      ?  QuizMenuNav()
      : _navBarIndex == 2
      ?  QuizLiveNav()
      :  QuizProfileNav();

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "কুইজ",
        iconData: FontAwesomeIcons.bars,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  /// custom bottom navigation bar
  Widget _pageBottomNavigationBar() => Theme(
    data: Theme.of(context).copyWith(canvasColor: CColor.themeColor),
    child: BottomNavigationBar(
        onTap: (value) {
          setState(() => _navBarIndex = value);
        },
        currentIndex: _navBarIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade300,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'হোম'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view), label: 'মেনু'),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv), label: 'লাইভ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'প্রোফাইল'),
        ]),
  );

}
