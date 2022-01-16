import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class QuizCustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Container(
      width: double.infinity,
      color: Colors.white70,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: size*.05),
          Container(
            width: size,
            padding: EdgeInsets.fromLTRB(size*.02, size*.02, size*.02, size*.01),
            decoration: BoxDecoration(
                color: Colors.pink.shade50.withOpacity(0.6),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(size*.04), bottomLeft: Radius.circular(size*.04))
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300, width: size*.015)
                      ),

                      /// profile image
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: size * .15,
                        backgroundImage:  const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnELq88FqJJ3fRj93adsIGYvhO-TiVlgimVQ&usqp=CAU'),
                      ),
                    ),
                    Positioned(
                      top: size*.05,
                      right: -size*.008,
                      child: Image.asset('assets/demo_badge.png',
                          height: size*.08,
                          width: size*.08),
                    )
                  ],
                ),
                SizedBox(height: size*.02,),

                /// username
                Container(
                  width: size,
                  alignment: Alignment.center,
                  child: Text(
                    'Username',
                    textAlign: TextAlign.center,
                    style: Style.bodyTextStyle(size*.05, Colors.black, FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size*.02),
          Container(
            width: size,
            color: CColor.themeColor,
            padding: EdgeInsets.fromLTRB(size*.2, size*.02, size*.1, size*.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// email address
                Text(
                  'username.math@gmail.com',
                  style: Style.bodyTextStyle(size*.035, Colors.white, FontWeight.w400),
                ),
                SizedBox(height: size*.01),
                Row(
                  children: [
                    Text(
                      'Coin : ',
                      style: Style.bodyTextStyle(size*.035, Colors.white, FontWeight.w400),
                    ),

                    /// user earned coin
                    Text(
                      '100',
                      style: Style.bodyTextStyle(size*.035, Colors.white, FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: size*.01),
                Row(
                  children: [
                    Text(
                      'Point : ',
                      style: Style.bodyTextStyle(size*.04, Colors.white, FontWeight.w300),
                    ),

                    /// user earned point
                    Text(
                      '100',
                      style: Style.bodyTextStyle(size*.04, Colors.white, FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // SizedBox(height: size*.02),
          Card(
            color: Colors.grey.shade200,
            elevation: 2,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // if you need this
              side: BorderSide(
                color: Colors.grey,
                width: size*.005,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size*.02, horizontal: size*.02),

              /// user earned badges
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/demo_badge.png', height: size*.08, width: size*.08),
                  SizedBox(width: size*.015,),
                  Image.asset('assets/demo_badge.png', height: size*.08, width: size*.08),
                  SizedBox(width: size*.015,),
                  Image.asset('assets/demo_badge.png', height: size*.08, width: size*.08),
                  SizedBox(width: size*.015,),
                  Container(
                      width: size*.08,
                      height: size*.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            //fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.grey.shade200.withOpacity(0.2), BlendMode.dstATop),
                              image: const AssetImage('assets/demo_badge.png')
                          )
                      )),
                  SizedBox(width: size*.015,),
                  Container(
                      width: size*.08,
                      height: size*.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            //fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.grey.shade200.withOpacity(0.2), BlendMode.dstATop),
                              image: const AssetImage('assets/demo_badge.png')
                          )
                      )),
                  SizedBox(width: size*.015,),
                  Container(
                      width: size*.08,
                      height: size*.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            //fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(Colors.grey.shade200.withOpacity(0.2), BlendMode.dstATop),
                              image: const AssetImage('assets/demo_badge.png')
                          )
                      )),
                  SizedBox(width: size*.015,),
                  Container(
                      width: size*.08,
                      height: size*.08,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(Colors.grey.shade200.withOpacity(0.2), BlendMode.dstATop),
                              image: const AssetImage('assets/demo_badge.png')
                          )
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: size*.04),
          _drawerOption(size, Image.asset("assets/exam_result.png", width: size * .07, height: size*.07,),'পরীক্ষার ফলাফল'),
          _drawerOption(size, Icon(LineAwesomeIcons.heart_1, size: size*.07, color: CColor.themeColor,),'পছন্দের প্রশ্ন'),
          _drawerOption(size, Image.asset("assets/my_question_icon.png", width: size * .07, height: size*.07,),'আমার প্রশ্ন'),
          _drawerOption(size, Image.asset("assets/syllabus_icon.png", width: size * .07, height: size*.07,),'সিলেবাস'),
          _drawerOption(size, Image.asset("assets/routine_icon.png", width: size * .07, height: size*.07,),'রুটিন'),
          _drawerOption(size, Image.asset("assets/coin_collection_icon.png", width: size * .07, height: size*.07,),'কয়েন সংগ্রহ'),
          _drawerOption(size, Image.asset("assets/point_collection_icon.png", width: size * .07, height: size*.07,),'পয়েন্ট সংগ্রহ'),
          _drawerOption(size, Image.asset("assets/refer_icon.png", width: size * .07, height: size*.07,),'রেফার'),
          _drawerOption(size, Image.asset("assets/download_icon.png", width: size * .07, height: size*.07,),'ডাউনলোড'),
          SizedBox(height: size*.1),
        ],
      ),
    );
  }

  Widget _drawerOption(double size, Widget icon, String title) => GestureDetector(
    onTap: (){

    },
    child: Padding(
      padding: EdgeInsets.fromLTRB(size*.15, size*.02, size*.04, size*.01),
      child: Row(
        children: [
          icon,
          SizedBox(width: size*.04),
          Text(title,
            style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),)
        ],
      ),
    ),
  );
}
