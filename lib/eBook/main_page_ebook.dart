import 'package:flutter/material.dart';
import 'package:read_on/public_variables/widget_variavles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return SafeArea(
    //     child:Scaffold(
    //       appBar: AppBar(elevation: 0.0),
    //       body: WidgetVariable.ebookNavBodyList.elementAt(_selectedIndex),
    //       bottomNavigationBar: BottomNavigationBar(
    //         currentIndex: _selectedIndex,
    //         items: langController.bottomNavItem.map((model) =>
    //             BottomNavigationBarItem(
    //               icon: Icon(model.icon, size: langController.size.value*.08),
    //               label: model.label,
    //             )).toList(),
    //         onTap: _onItemTapped,
    //       ),
    //     ));
  }
}
