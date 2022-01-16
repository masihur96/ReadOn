import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import '../../widgets/custom_appbar.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/solid_button.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize, child: _pageAppBar()),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wallet_bg.png'), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(height: size * .35),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.shade300, width: size * .012)),

                  /// profile image
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size * .15,
                    backgroundImage: const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnELq88FqJJ3fRj93adsIGYvhO-TiVlgimVQ&usqp=CAU'),
                  ),
                ),
                Positioned(
                  top: size * .05,
                  right: -size * .02,
                  child: Image.asset('assets/demo_badge.png',
                      height: size * .08, width: size * .08),
                )
              ],
            ),
            SizedBox(height: size * .03),
            Container(
                width: size,
                alignment: Alignment.center,
                child: Text(
                  'Username',
                  textAlign: TextAlign.center,
                  style: Style.bodyTextStyle(
                      size * .05, Colors.black, FontWeight.w500),
                )),
            SizedBox(height: size * .02),
            Container(
              width: size,
              color: const Color(0xffF1F3F2),
              padding: EdgeInsets.symmetric(vertical: size * .02),
              margin: EdgeInsets.symmetric(horizontal: size * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// email address
                  Text(
                    'username.math@gmail.com',
                    style: Style.bodyTextStyle(
                        size * .035, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(height: size * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Coin : ',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),

                      /// user earned coin
                      Text(
                        '100',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: size * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Point : ',
                        style: Style.bodyTextStyle(
                            size * .04, Colors.black, FontWeight.w500),
                      ),

                      /// user earned point
                      Text(
                        '100',
                        style: Style.bodyTextStyle(
                            size * .04, Colors.black, FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size * .02),

            /// earned badge section
            Card(
              color: const Color(0xffF1F3F2),
              elevation: 2,
              margin: EdgeInsets.only(left: size * .05, right: size * .05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(size * .01),
                side: BorderSide(
                  color: const Color(0xffB4B4B4),
                  width: size * .005,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: size * .02, horizontal: size * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/demo_badge.png',
                        height: size * .08, width: size * .08),
                    SizedBox(
                      width: size * .015,
                    ),
                    Image.asset('assets/demo_badge.png',
                        height: size * .08, width: size * .08),
                    SizedBox(
                      width: size * .015,
                    ),
                    Image.asset('assets/demo_badge.png',
                        height: size * .08, width: size * .08),
                    SizedBox(
                      width: size * .015,
                    ),
                    Container(
                        width: size * .08,
                        height: size * .08,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade200.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/demo_badge.png')))),
                    SizedBox(
                      width: size * .015,
                    ),
                    Container(
                        width: size * .08,
                        height: size * .08,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                //fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade200.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/demo_badge.png')))),
                    SizedBox(
                      width: size * .015,
                    ),
                    Container(
                        width: size * .08,
                        height: size * .08,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                //fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade200.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/demo_badge.png')))),
                    SizedBox(
                      width: size * .015,
                    ),
                    Container(
                        width: size * .08,
                        height: size * .08,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey.shade200.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image: const AssetImage(
                                    'assets/demo_badge.png')))),
                  ],
                ),
              ),
            ),
            SizedBox(height: size * .06,),

            /// balance & coin section
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: size * .05),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(size * .01),
                border: Border.all(color: const Color(0xffEF94A2), width: 1)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(vertical: size * .02),
                        color: const Color(0xffF1F3F2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ব্যালেন্স : ',
                              style: Style.bodyTextStyle(
                                  size * .045, Colors.black, FontWeight.w500),
                            ),
                            Text(
                              '00',
                              style: Style.bodyTextStyle(
                                  size * .045, Colors.black, FontWeight.w500),
                            )
                          ],
                        ),
                      )),
                      SizedBox(
                        width: size * .01,
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(vertical: size * .015),
                        alignment: Alignment.center,
                        color: const Color(0xffF1F3F2),
                        child: SolidColorButton(
                          borderRadius: size * .02,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: size * .12, vertical: size * .01),
                          onPressed: () {},
                          child: Text(
                            'রিচার্জ',
                            style: Style.buttonTextStyle(
                                size * .04, Colors.white, FontWeight.w500),
                          ),
                          bgColor: const Color(0xff87B078),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: size*.03,),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: size * .02),
                            color: const Color(0xffF1F3F2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'কয়েন : ',
                                  style: Style.bodyTextStyle(
                                      size * .045, Colors.black, FontWeight.w500),
                                ),
                                Text(
                                  '১00',
                                  style: Style.bodyTextStyle(
                                      size * .045, Colors.black, FontWeight.w500),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: size * .015),
                            alignment: Alignment.center,
                            color: const Color(0xffF1F3F2),
                            child: SolidColorButton(
                              borderRadius: size * .02,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: size * .05, vertical: size * .01),
                              onPressed: () {},
                              child: Text(
                                'টাকায় রুপান্তর',
                                style: Style.buttonTextStyle(
                                    size * .04, Colors.white, FontWeight.w500),
                              ),
                              bgColor: const Color(0xff87B078),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size * .06,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size*.02, vertical: size*.02),
                  margin: EdgeInsets.only(right: size*.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size * .02),
                      border: Border.all(color: const Color(0xffEF94A2), width: 1)
                  ),
                  child: Column(
                    children: [
                      Icon(LineAwesomeIcons.coins, color: const Color(0xffD4032B),size: size*.08),
                      SizedBox(height: size*.01,),
                      Text('কয়েন সংগ্রহ',
                      style: Style.bodyTextStyle(size*.035, Colors.black, FontWeight.w500),)
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size*.02, vertical: size*.02),
                  margin: EdgeInsets.only(left: size*.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size * .02),
                      border: Border.all(color: const Color(0xffEF94A2), width: 1)
                  ),
                  child: Column(
                    children: [
                      Icon(LineAwesomeIcons.hand_holding_heart, color: const Color(0xffD4032B),size: size*.08),
                      SizedBox(height: size*.01,),
                      Text('পয়েন্ট সংগ্রহ',
                        style: Style.bodyTextStyle(size*.035, Colors.black, FontWeight.w500),)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );

  CustomAppBar _pageAppBar() => CustomAppBar(
        title: "ওয়ালেট",
        iconData: LineAwesomeIcons.arrow_left,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );
}
