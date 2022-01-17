import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_appbar.dart';

class ContentDetails extends StatefulWidget {
  String contentTitle;

  ContentDetails({Key? key, required this.contentTitle}) : super(key: key);

  @override
  _ContentDetailsState createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _divisionList = [
    'All English',
    '30 writers of literary pieces',
    'Parts. of Speech',
    'Idioms & Phrases'
  ];
  final _dropdownList = [
    'All English',
    '30 writers of literary pieces from',
    'Parts. of Speech',
    'Idioms & Phrases'
  ];
  String? dropDownVal;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: _pageAppBar(size)),
            body: ListView(children: [
              Visibility(
                visible: widget.contentTitle == 'বাংলা ভাষা ও সাহিত্য',
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 0.0),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {}, child: buttonWidget(size, 'মধ্যযুগ'));
                  },
                ),
              ),
              SizedBox(
                height: size.width * .1,
              ),
              Visibility(
                visible: widget.contentTitle != 'বাংলা ভাষা ও সাহিত্য',
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                  child: Container(
                    height: size.width * .1,
                    width: size.width * .7,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                    ),
                    child: Center(
                        child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        onChanged: (value) {},
                        hint: Text(
                          'Select Unit',
                          style: TextStyle(
                            fontSize: size.width * .05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: _divisionList
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Container(
                                    color: Colors.grey.shade300,
                                    margin: EdgeInsets.only(
                                        bottom: size.width * .01),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                            size.width * .00,
                                          ),
                                          child: Center(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: size.width * .04,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        iconSize: 24,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.white,
                        buttonPadding:
                            const EdgeInsets.only(left: 12, right: 12),
                        buttonElevation: 2,
                        dropdownMaxHeight: 400,
                        dropdownPadding: EdgeInsets.zero,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, -8),
                        itemPadding: EdgeInsets.zero,
                      ),
                    )),
                  ),
                ),
              ),
              Visibility(
                visible: widget.contentTitle != 'বাংলা ভাষা ও সাহিত্য',
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return whiteButton(size, 'The noun');
                    }),
              ),
            ])));
  }

  Widget whiteButton(Size size, String title) {
    return Column(
      children: [
        SizedBox(
          height: size.width * .04,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            height: size.width * .1,
            width: size.width * .8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 2)),
            child: Center(
                child: Text(
              title,
              style: Style.buttonTextStyle(
                  size.width * .06, Colors.black, FontWeight.normal),
            )),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget(Size size, String buttonTitle) {
    return Column(
      children: [
        SizedBox(
          height: size.width * .1,
        ),
        Container(
          height: size.width * .1,
          width: size.width * .4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey, width: 2)),
          child: Center(
              child: Text(
            buttonTitle,
            style: Style.buttonTextStyle(
                size.width * .06, Colors.black, FontWeight.normal),
          )),
        ),
      ],
    );
  }

  /// app bar
  CustomAppBar _pageAppBar(Size size) => CustomAppBar(
        title: widget.contentTitle,
        iconData: LineAwesomeIcons.arrow_left,
        action: [
          Icon(
            Icons.menu_outlined,
            color: Colors.white,
            size: size.width * .08,
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );
}
