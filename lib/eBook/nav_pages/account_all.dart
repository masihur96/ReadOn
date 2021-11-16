import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/amar_account_options.dart';
import 'package:read_on/public_variables/color_variable.dart';

class AccountPageAll extends StatelessWidget {
  const AccountPageAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return  Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(double size) => Container(
    width: Get.width,
    height: Get.height,
    child: ListView(
      children: [
        Image.asset('assets/amar_account_bg.png', fit: BoxFit.cover,width: double.infinity, height: size*.7,),
        SizedBox(height: size*.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.1),
          child: Column(
            children: [

              /// subscription plan
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: size*.03),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [CColor.themeColor,CColor.themeColorLite]
                    ),
                    borderRadius: BorderRadius.circular(size*.1)
                ),
                child: Text(
                  'সাবস্ক্রিপশন প্লান',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size*.05,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: size*.04,),

              /// options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AmarAccountOptions(child: Icon(Icons.person, color: Colors.white,size: size*.1), title: 'প্রোফাইল',),
                  AmarAccountOptions(child: Icon(LineAwesomeIcons.book, color: Colors.white,size: size*.1), title: 'ইবুক',),
                  AmarAccountOptions(child: Icon(Icons.alarm_on, color: Colors.white,size: size*.1), title: 'কুইজ',),
                ],
              ),
              SizedBox(height: size*.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AmarAccountOptions(child: Icon(Icons.smart_display_outlined, color: Colors.white,size: size*.1), title: 'কোর্স',),
                  AmarAccountOptions(child: Icon(Icons.help_outline, color: Colors.white,size: size*.1), title: 'ব্যবহারের নিয়ম',),
                  AmarAccountOptions(child: Column(
                    children: [
                      Container(
                        width: size*.08,
                        height: size*.08,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        alignment: Alignment.center,
                        child: Text('ট', style: TextStyle(color: Colors.red, fontSize: size*.065, fontFamily: 'Kalpurush', fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: size*.008,),
                    ],
                  ), title: 'টাকা ফেরত'),
                ],
              ),
              SizedBox(height: size*.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AmarAccountOptions(child: Icon(Icons.groups, color: Colors.white,size: size*.1), title: 'আমাদের সম্পর্কে',),
                  AmarAccountOptions(child: SizedBox(
                    width: size*.13,
                    height: size*.08,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(LineAwesomeIcons.hand_holding_heart, color: Colors.white,size: size*.06)),
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: Icon(LineAwesomeIcons.coins, color: Colors.white,size: size*.06)),
                      ],
                    ),
                  ), title: 'কয়েন  ও পয়েন্ট',),
                  AmarAccountOptions(child: SizedBox(
                    width: size*.13,
                    height: size*.08,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: 0,
                            child: Icon(LineAwesomeIcons.sms, color: Colors.white,size: size*.035)),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Icon(LineAwesomeIcons.user, color: Colors.white,size: size*.06)),
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: Icon(LineAwesomeIcons.user, color: Colors.white,size: size*.06)),
                      ],
                    ),
                  ), title: 'যোগাযোগ',),
                ],
              ),
              SizedBox(height: size*.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AmarAccountOptions(child: Column(
                    children: [
                      SizedBox(
                        width: size*.13,
                        height: size*.08,
                        child: Stack(
                          children: [
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(Icons.settings, color: Colors.white,size: size*.06)),
                            Positioned(
                                left: 0,
                                bottom: 0,
                                child: Icon(Icons.lock, color: Colors.white,size: size*.06)),
                          ],
                        ),
                      ),
                      SizedBox(height: size*.008,),
                    ],
                  ), title: 'সেটিংস ও প্রাইভেসি',),
                  AmarAccountOptions(child: Icon(LineAwesomeIcons.bell, color: Colors.white,size: size*.1), title: 'নোটিফিকেশন',),
                  AmarAccountOptions(child: Icon(LineAwesomeIcons.alternate_sign_out, color: Colors.white,size: size*.1), title: 'লগ আউট',),

                ],
              ),
              SizedBox(height: size*.02),
            ],
          ),
        ),
      ],
    ),
  );
}
