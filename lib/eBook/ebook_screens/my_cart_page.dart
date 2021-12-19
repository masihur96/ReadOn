import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/ebook_cart_tab.dart';
import 'package:read_on/eBook/ebook_widgets/hard_copy_cart_tab.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import '../ebook_widgets/custom_appbar.dart';


class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  /// page body
  Container _bodyUI(double size) =>
      Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children:  [
              TabBar(
                labelColor: CColor.themeColor,
                unselectedLabelColor: Colors.black,
                labelStyle: Style.bodyTextStyle(size*.04, CColor.themeColor, FontWeight.w500),
                  unselectedLabelStyle: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.normal),
                  tabs: const [
                    Tab(
                      text: 'ইবুক',
                    ),
                    Tab(
                      text: 'হার্ড কপি',
                    )
                  ]
              ),
              Expanded(
                child: TabBarView(children: [
                  EBookCartTab(),
                  HardCopyCartTab()
                ]),
              )
            ],
          ),
        ),
      );

  /// app bar
  CustomAppBar _pageAppBar(PublicController publicController) => CustomAppBar(
        title: "আমার কার্ট",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );

}
