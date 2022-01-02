import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/solid_button.dart';
import 'package:shimmer/shimmer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _loading = false;
  int _count = 0;
  List<String> _divisionList = [];
  int _radioButtonValue = 1;

  void _customInit(PublicController publicController) async {
    setState(() {
      _count++;
      _loading = true;
    });
    await publicController.getDivisionList().then((value) {
      for (int i = 0;
          i < publicController.divisionModel.value.data!.length;
          i++) {
        setState(() {
          _divisionList
              .add(publicController.divisionModel.value.data![i].divisionbn!);
        });
      }
    });

    // ignore: avoid_print
    print("Division list = $_divisionList");
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    if (_count == 0) _customInit(publicController);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(publicController)),
        body: _bodyUI(size, publicController),
      ),
    );
  }

  Widget _bodyUI(double size, PublicController publicController) => Padding(
        padding: EdgeInsets.all(size * .04),
        child: _loading
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size * .4,
                                  height: size * .08,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .3,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .2,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .3,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .4,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                Container(
                                  width: size * .4,
                                  height: size * .08,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                SizedBox(
                                  width: size,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: size * .06,
                                            height: size * .06,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(left: size*.02),
                                                width: size * .25,
                                                height: size * .04,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: size*.01,),
                                              Container(
                                                margin: EdgeInsets.only(left: size*.02),
                                                width: size * .2,
                                                height: size * .04,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: size * .05,
                                            height: size * .05,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: size*.02),
                                            width: size * .25,
                                            height: size * .04,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                Container(
                                  width: size,
                                  height: size*.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(size * .03),
                                  ),
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: size * .3,
                                    height: size * .1,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'প্রেরণের ঠিকানা',
                    style: Style.bodyTextStyle(
                        size * .05, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'বিভাগ',
                          style: Style.bodyTextStyle(
                              size * .04, Colors.black, FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: size * .5,
                        height: size * .1,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'বিভাগ নির্বাচন করুন',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          items: _divisionList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: size * .04,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'বিভাগ নির্বাচন করুন';
                            }
                          },
                          onChanged: (value) {
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value) {
                            //selectedValue = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(size, 'জেলা', "জেলার নাম লিখুন"),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(size, 'উপজেলা/থানা', "উপজেলা/থানার নাম লিখুন"),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(size, 'গ্রাম/মহল্লা/রাস্তা/বাড়ি নম্বর',
                      "গ্রাম/মহল্লা/রাস্তা/বাড়ি নম্বর"),
                  SizedBox(
                    height: size * .1,
                  ),
                  Text(
                    'পেমেন্ট পদ্ধতি',
                    style: Style.bodyTextStyle(
                        size * .05, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size * .03),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size * .02, vertical: size * .04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size * .03),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    activeColor: CColor.themeColor,
                                    value: 1,
                                    groupValue: _radioButtonValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioButtonValue = value as int;
                                      });
                                    }),
                                Expanded(
                                  child: Text(
                                    'বিকাশ, নগদ, ব্যাংক ও অন্যান্য',
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    activeColor: CColor.themeColor,
                                    value: 2,
                                    groupValue: _radioButtonValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioButtonValue = value as int;
                                      });
                                    }),
                                Text(
                                  'রিডঅন কয়েন',
                                  style: Style.bodyTextStyle(size * .04,
                                      Colors.black, FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size * .02,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size * .03),
                        side: const BorderSide(color: Colors.grey, width: 0.5)),
                    child: Container(
                      width: size * .98,
                      padding: EdgeInsets.symmetric(vertical: size * .04),
                      child: Column(
                        children: [
                          /// cart cost details
                          _costDetailPreview(size, 'মোট', "১০০০"),
                          _costDetailPreview(size, 'ডেলিভারি চার্জ', "১০"),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .05),
                            child: Divider(
                              thickness: size * .003,
                              color: Colors.grey,
                            ),
                          ),
                          _costDetailPreview(size, 'সর্বমোট', "১০১০"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SolidColorButton(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: size * .02, horizontal: size * .1),
                        borderRadius: size * .025,
                        child: Text('অর্ডার করুন',
                            style: Style.buttonTextStyle(
                                size * .04, Colors.white, FontWeight.w500)),
                        onPressed: () {},
                        bgColor: CColor.themeColor),
                  ),
                ],
              ),
      );

  /// app bar
  CustomAppBar _pageAppBar(PublicController publicController) => CustomAppBar(
        title: "অর্ডার করুন",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  /// custom field
  Widget _customField(double size, String title, String hint) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Style.bodyTextStyle(
                  size * .04, Colors.black, FontWeight.normal),
            ),
          ),
          SizedBox(
            width: size * .5,
            height: size * .1,
            child: TextFormField(
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: size * .04),
                isDense: false,
                contentPadding: EdgeInsets.only(left: size * .04),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
              ),
            ),
          ),
        ],
      );

  ///custom cost detail field
  Widget _costDetailPreview(double size, String title, String value) => Padding(
        padding:
            EdgeInsets.symmetric(vertical: size * .01, horizontal: size * .1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.bodyTextStyle(
                    size * .04, Colors.black, FontWeight.w500),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(width: size * .04),
                  Text(
                    'টাকা',
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
