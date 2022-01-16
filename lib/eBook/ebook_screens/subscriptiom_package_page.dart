import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import '../../widgets/custom_appbar.dart';
import 'package:read_on/eBook/ebook_widgets/package_page.dart';
import 'package:read_on/eBook/ebook_widgets/subscription_plan_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/gradient_button.dart';

class SubscriptionPackagePage extends StatefulWidget {
  const SubscriptionPackagePage({Key? key}) : super(key: key);

  @override
  _SubscriptionPackagePageState createState() =>
      _SubscriptionPackagePageState();
}

class _SubscriptionPackagePageState extends State<SubscriptionPackagePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.put(EbookApiController());
    double size = publicController.size.value;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController),
          ),
          body: _bodyUI(size),
        ),
      ),
    );
  }

  /// body
  Widget _bodyUI(double size) => Column(
    children: [
      TabBar(
          labelColor: CColor.themeColor,
          unselectedLabelColor: Colors.black,
          labelStyle: Style.bodyTextStyle(size*.045, CColor.themeColor, FontWeight.w500),
          tabs: [
            Padding(
              padding: EdgeInsets.all(size*.03),
              child: const Text(
                'সাবস্কিপশন প্ল্যান',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size*.03),
              child: const Text(
                'প্যাকেজ',
              ),
            ),
          ]),
       Expanded(
         child: TabBarView(children: [
          const SubscriptionPlanPage(),
          PackagePage(),
      ]),
       )
    ],
  );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: 'সাবস্ক্রিপশন ও প্যাকেজ',
        iconData: LineAwesomeIcons.arrow_left,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );


}
