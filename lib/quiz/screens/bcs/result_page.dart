import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
        body: _bodyUI(size),
      ),
    );
  }

  /// body
  Widget _bodyUI(double size) => Padding(
    padding: EdgeInsets.symmetric(vertical: size*.03),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.05, vertical: size*.025),
          child: _resultPreview(size),
        );
      },
    ),
  );


  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "ফলাফল",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  /// result preview
  Widget _resultPreview(double size) => Column(
    children: [
      Container(
        width: size,
        padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.03),
        decoration: BoxDecoration(
          color: const Color(0xffD4D4D4),
          border: Border.all(color: const Color(0xffD4D4D4), width: 1),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(size*.04), topRight: Radius.circular(size*.04)),
        ),
        child: Text(
          '১০ ডিসেম্বর ২০২২, শনিবার',
          textAlign: TextAlign.center,
          style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
        ),
      ),
      Container(
        width: size,
        padding: EdgeInsets.symmetric(horizontal: size*.04, vertical: size*.03),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: CColor.themeColor, width: 1),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(size*.04), bottomRight: Radius.circular(size*.04)),
        ),
        child: Text(
          'অপরাজিতা',
          textAlign: TextAlign.center,
          style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
        ),
      )
    ],
  );
}
