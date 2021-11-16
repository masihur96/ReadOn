import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/registration_page.dart';
import 'package:read_on/widgets/custom_text_form_field.dart';
import 'package:read_on/widgets/gradient_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneEmailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');

  String? _phoneEmailErrorText;
  String? _passwordErrorText;

  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/home_bg.png'), fit: BoxFit.cover)),
      padding: EdgeInsets.symmetric(horizontal: size*.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo_with_name.png',
            width: size * .4,
            height: size * .4,
          ),
          SizedBox(
            height: size * .05,
          ),
          CustomTextFormField(
            size: size,
            textEditingController: _phoneEmailController,
            hintText: 'ইমেইল অথবা মোবাইল নম্বর',
            prefixIcon: LineAwesomeIcons.address_card,
            errorText: _phoneEmailErrorText,
            obscureText: false,
            suffix: null,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: size * .02),
          CustomTextFormField(
            size: size,
            textEditingController: _passwordController,
            hintText: 'পাসওয়ার্ড',
            prefixIcon: LineAwesomeIcons.key,
            errorText: _passwordErrorText,
            obscureText: _passwordObscureText,
            suffix: InkWell(
              onTap: () {
                setState(
                        () => _passwordObscureText = !_passwordObscureText);
              },
              child: Icon(
                _passwordObscureText
                    ? LineAwesomeIcons.eye
                    : LineAwesomeIcons.eye_slash,
                color: CColor.themeColor,
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: size * .02),
          GradientButton(
              child: Text(
                'লগইন',
                style: Style.bodyTextStyle(
                    size * .05, Colors.white, FontWeight.w500),
              ),
              onPressed: () {},
              borderRadius: size * .01,
              height: size * .12,
              width: double.infinity,
              gradientColors: const [
                CColor.themeColor,
                CColor.themeColorLite
              ]),
          SizedBox(height: size * .02),
          Text(
            'অথবা,',
            style: Style.bodyTextStyle(
                size * .04, const Color(0xff5D5D5D), FontWeight.w500),
          ),
          SizedBox(height: size * .02),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: size * .12,
                  margin: EdgeInsets.only(right: size * .01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .01),
                    color: const Color(0xff3B5797),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        LineAwesomeIcons.facebook_square,
                        color: Colors.white,
                        size: size * .1,
                      ),
                      SizedBox(
                        width: size * .02,
                      ),
                      Text(
                        'Facebook',
                        style: Style.bodyTextStyle(
                            size * .04, Colors.white, FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: size * .12,
                  margin: EdgeInsets.only(left: size * .01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .01),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/google_icon.png',
                        height: size * .1,
                        width: size * .1,
                      ),
                      SizedBox(
                        width: size * .01,
                      ),
                      Text(
                        'Google',
                        style: Style.bodyTextStyle(size * .04,
                            const Color(0xff5D5D5D), FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size * .1),
          Padding(
            padding: EdgeInsets.all(size*.02),
            child: Text(
              'পাসওয়ার্ড ভুলে গেছেন?',
              style: Style.bodyTextStyle(
                  size * .04, Colors.black, FontWeight.bold),
            ),
          ),
          SizedBox(height: size * .04),
          RichText(
              text: TextSpan(
                  style: Style.bodyTextStyle(
                      size * .04, Colors.black, FontWeight.normal),
                  children: [
                    const TextSpan(
                      text: 'পূর্ব রেজিস্ট্রেশন নেই? ',
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const RegistrationPage());
                          },
                        text: 'রেজিস্ট্রেশন করুন',
                        style: Style.bodyTextStyle(
                            size * .04, CColor.themeColor, FontWeight.w500)),
                  ]))
        ],
      ),
    ),
  );
}
