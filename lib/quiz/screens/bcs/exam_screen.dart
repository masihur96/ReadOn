import 'package:custom_pointed_popup/custom_pointed_popup.dart';
import 'package:custom_pointed_popup/utils/triangle_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_screens/story_preview.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:read_on/quiz/screens/bcs/recent_test_screen.dart';
import 'package:read_on/quiz/screens/bcs/result_screen.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  CustomPointedPopup? customPointedPopup;
  int _radioSelected = 1;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar(size)),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size * .02,
                  ),
                  Container(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: EdgeInsets.all(
                        size * .04,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'বাকী সময় ০০:১০:৪০',
                            style: Style.bodyTextStyle(
                                size * .05, Colors.black, FontWeight.normal),
                          ),
                          Text(
                            '৫/৩',
                            style: Style.buttonTextStyle(
                                size * .05, Colors.black, FontWeight.normal),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.apps_outlined,
                                size: size * .08,
                              ),
                              SizedBox(
                                width: size * .02,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ResultScreen()));
                                },
                                child: Icon(
                                  Icons.zoom_out_map_sharp,
                                  size: size * .08,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final GlobalKey widgetKey = GlobalKey();
                        return questionTile(size, index, widgetKey);
                      }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RecentTest()));
                },
                child: Container(
                  width: size * .4,
                  height: size * .1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.redAccent, width: 2),
                      color: Colors.grey.shade300),
                  child: Center(
                    child: Text(
                      'জমা দিন',
                      style: Style.bodyTextStyle(
                          size * .06, Colors.black, FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget questionTile(double size, int index, GlobalKey widgetKey) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '$index',
                  style: Style.bodyTextStyle(
                      size * .04, Colors.black, FontWeight.normal),
                ),
                SizedBox(
                  width: size * .03,
                ),
                Text(
                  'বাংলাদেশের রাজধানীর নাম কি ?',
                  style: Style.buttonTextStyle(
                      size * .04, Colors.black, FontWeight.normal),
                ),
              ],
            ),
            InkWell(
                key: widgetKey,
                onTap: () {
                  getCustomPointedPopup(context, size, 1)!.show(
                    widgetKey: widgetKey,
                  );

                  print('POPUP');
                },
                child: Icon(Icons.more_vert_outlined))
          ],
        ),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: _radioSelected,
              activeColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                });
              },
            ),
            Text('ঢাকা')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: _radioSelected,
              activeColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                });
              },
            ),
            Text('চটরগ্রাম')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 3,
              groupValue: _radioSelected,
              activeColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                });
              },
            ),
            Text('খুলনা')
          ],
        ),
        Row(
          children: [
            Radio(
              value: 4,
              groupValue: _radioSelected,
              activeColor: Colors.grey,
              onChanged: (value) {
                setState(() {
                  _radioSelected = value as int;
                });
              },
            ),
            const Text('বরিশাল')
          ],
        ),
      ],
    );
  }

  CustomPointedPopup? getCustomPointedPopup(
      BuildContext context, double size, int index) {
    customPointedPopup = CustomPointedPopup(
      backgroundColor: Colors.white,
      context: context,
      widthFractionWithRespectToDeviceWidth: 3,
      displayBelowWidget: true,
      triangleDirection: TriangleDirection.Straight,
      popupElevation: 3,
      item: CustomPointedPopupItem(
          textStyle: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).cardColor,
              ),
          itemWidget: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.redAccent)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        customPointedPopup!.dismiss();
                        // Get.to(() => StoryPreview(bookId: "89"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/heart_icon.png',
                            height: size * .07,
                            width: size * .07,
                          ),
                          Text(
                            'Favorite',
                            style: Style.buttonTextStyle(
                                size * .04, Colors.black, FontWeight.bold),
                          )
                        ],
                      )),
                  SizedBox(
                    height: size * .04,
                  ),
                  InkWell(
                      onTap: () async {
                        customPointedPopup!.dismiss();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/help_icon.png',
                            height: size * .08,
                            width: size * .08,
                          ),
                          Text(
                            'Help',
                            style: Style.buttonTextStyle(
                                size * .04, Colors.black, FontWeight.bold),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
    return customPointedPopup;
  }

  /// app bar
  CustomAppBar _pageAppBar(double size) => CustomAppBar(
        title: 'লাইভ টেস্ট',
        iconData: LineAwesomeIcons.arrow_left,
        action: [
          Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: size * .08,
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}
