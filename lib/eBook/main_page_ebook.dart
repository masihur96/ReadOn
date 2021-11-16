import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_drawer.dart';
import 'package:read_on/eBook/my_cart_page.dart';
import 'package:read_on/eBook/nav_pages/account_all.dart';
import 'package:read_on/eBook/nav_pages/audio_book.dart';
import 'package:read_on/eBook/nav_pages/home_ebook.dart';
import 'package:read_on/eBook/nav_pages/library.dart';
import 'package:read_on/eBook/nav_pages/my_book.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'ebook_widgets/custom_appbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _navBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: CustomDrawer()),
          body: _bodyUI(publicController),
        ),
        bottomNavigationBar: _pageBottomNavigationBar(),
      ),
    );
  }

  /// page body
  Widget _bodyUI(PublicController publicController) => _navBarIndex == 0
      ? const HomePageEbook()
      : _navBarIndex == 1
          ? const LibraryPage()
          : _navBarIndex == 2
              ? const AudioBookPage()
              : _navBarIndex == 3
                  ? const MyBookPage()
                  : const AccountPageAll();

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) => CustomAppBar(
        title: "ইবুক",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
          SizedBox(width: size * .04),
          GestureDetector(
            onTap: () {
              Get.to(() => MyCartPage());
            },
            child: Container(
              width: size * .085,
              height: size * .085,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Icon(
                    LineAwesomeIcons.shopping_cart,
                    color: Colors.white,
                    size: size * .085,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: size * .035,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      /// notification count
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
                  icon: Icon(LineAwesomeIcons.home), label: 'হোম'),
              BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.book_reader), label: 'বইঘর'),
              BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.headphones), label: 'অডিও বই'),
              BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.book_open), label: 'আমার বই'),
              BottomNavigationBarItem(
                  icon: Icon(LineAwesomeIcons.user), label: 'প্রোফাইল'),
            ]),
      );
}
