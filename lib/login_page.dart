import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/home_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:read_on/registration_page.dart';
import 'package:read_on/widgets/custom_loading.dart';
import 'package:read_on/widgets/custom_text_form_field.dart';
import 'package:read_on/widgets/gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneEmailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  String? _phoneEmailErrorText;
  String? _passwordErrorText;

  bool _passwordObscureText = true;
  bool _rememberLogin = false;
  bool _loading = false;

  String? deviceId;
  int _count = 0;

  void _customInit(PublicController publicController) async {
    _count++;
    await publicController.getMacAddress().then((value) {
      setState(() {
        deviceId = publicController.deviceId;
      });
      print('device ID = $deviceId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.put(UserController());
    final double size = publicController.size.value;
    if(_count == 0) _customInit(publicController);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _bodyUI(size, userController),
            Visibility(
              visible: _loading? true: false,
              child: Container(
                width: Get.width,
                height: Get.height,
                color: Colors.black38,
                child: const CustomLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyUI(double size, UserController userController) => SingleChildScrollView(
        child: Column(
          children: [

            /// email or phone input field
            SizedBox(
              width: Get.width,
              height: size * 1.4,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/login_page_bg.png',
                      width: size,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: size * .55,
                    child: Container(
                      width: size * .8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size * .2),
                              topRight: Radius.circular(size * .07),
                              bottomLeft: Radius.circular(size * .07),
                              bottomRight: Radius.circular(size * .07))),
                      padding: EdgeInsets.fromLTRB(
                          size * .1, size * .3, size * .1, size * .04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            size: size,
                            textEditingController: _phoneEmailController,
                            hintText: 'Email or Phone',
                            errorText: _phoneEmailErrorText,
                            obscureText: false,
                            suffix: null,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: size * .01),
                          Divider(
                            color: const Color(0xffD4D4D4),
                            thickness: size * .007,
                            height: size * .01,
                          ),
                          SizedBox(height: size * .01),
                          CustomTextFormField(
                            size: size,
                            textEditingController: _passwordController,
                            hintText: 'Password',
                            errorText: _passwordErrorText,
                            obscureText: _passwordObscureText,
                            suffix: InkWell(
                              onTap: () {
                                setState(() => _passwordObscureText =
                                    !_passwordObscureText);
                              },
                              child: Icon(
                                _passwordObscureText
                                    ? LineAwesomeIcons.eye
                                    : LineAwesomeIcons.eye_slash,
                                color: const Color(0xff98989A),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: size * .01),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberLogin,
                                activeColor: CColor.themeColor,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberLogin = value!;
                                  });
                                  print(_rememberLogin);
                                },
                              ),
                              Text(
                                'Remember me',
                                style: Style.bodyTextStyle(size * .04,
                                    Colors.black, FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: size * .38,
                    child: Container(
                        width: size * .35,
                        height: size * .35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(3, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(size * .07),
                        child: Image.asset('assets/logo_with_name.png')),
                  )
                ],
              ),
            ),

            /// login button
            SizedBox(
              width: size * .8,
              height: size * .12,
              child: GradientButton(
                  onPressed: () {
                    _login(userController);
                  },
                  borderRadius: size * .01,
                  height: size * .12,
                  width: double.infinity,
                  gradientColors: const [
                    CColor.themeColor,
                    CColor.themeColorLite
                  ],
                  child: Text(
                    'Login',
                    style: Style.buttonTextStyle(
                        size * .05, Colors.white, FontWeight.w500),
                  )),
            ),
            SizedBox(
              height: size * .04,
            ),
            Text(
              'or connect with',
              style: Style.bodyTextStyle(
                  size * .04, Colors.black, FontWeight.w500),
            ),
            SizedBox(
              height: size * .04,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .08),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size * .12,
                      margin: EdgeInsets.only(right: size * .01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .04),
                        color: const Color(0xff3B5797),
                      ),
                      child: Icon(
                        LineAwesomeIcons.facebook_f,
                        color: Colors.white,
                        size: size * .1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size * .12,
                      margin: EdgeInsets.only(left: size * .01),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .04),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffC8C8C8))),
                      child: Image.asset(
                        'assets/google_icon.png',
                        height: size * .1,
                        width: size * .1,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size * .04,
            ),

            /// forget password
            Padding(
              padding: EdgeInsets.all(size * .03),
              child: Text(
                'Forget Password?',
                style: Style.bodyTextStyle(
                    size * .04, CColor.themeColor, FontWeight.w500),
              ),
            ),
            SizedBox(
              height: size * .01,
            ),

            /// navigate to register page
            RichText(
                text: TextSpan(
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.normal),
                    children: [
                  const TextSpan(
                    text: 'Not on ReadOn yet? ',
                  ),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const RegistrationPage());
                        },
                      text: 'Sign up',
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.w500)),
                ])),
            SizedBox(
              height: size * .08,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .08),
              child: Divider(
                thickness: size * .01,
                color: const Color(0xffD4D4D4),
                height: size * .01,
              ),
            ),
            SizedBox(
              height: size * .02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .08),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.normal),
                      children: [
                        const TextSpan(
                          text: 'By continuing you agree to ReadOn ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => LoginPage());
                              },
                            text: 'Terms & Condition',
                            style: Style.bodyTextStyle(size * .04,
                                CColor.themeColorLite, FontWeight.w500)),
                        const TextSpan(
                          text: ' , ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => LoginPage());
                              },
                            text: 'Privacy Policy',
                            style: Style.bodyTextStyle(size * .04,
                                CColor.themeColorLite, FontWeight.w500)),
                      ])),
            ),
            SizedBox(
              height: size * .1,
            ),
          ],
        ),
      );

  void _login(UserController userController) async {
    String email = '';
    String phone = '';
    Map loginData = {};
    if (_phoneEmailController.text == '') {
      setState(() => _phoneEmailErrorText = 'আপনার মোবাইল নম্বর বা ইমেইল লিখুন');
      return;
    }else{
      if (_phoneEmailController.text.contains('@') && _phoneEmailController.text.contains('.com')) {
        email = _phoneEmailController.text;
        phone = '';
        setState(() => setState(() => _phoneEmailErrorText = null));
      } else {
        phone = _phoneEmailController.text;
        email = '';
        if (phone.length != 11 || !phone.contains('01')) {
          setState(() => setState(() => _phoneEmailErrorText = 'কমপক্ষে ১১ ডিজিটের মোবাইল নম্বর লিখুন অথবা ইমেইল লিখুন'));
          return;
        } else {
          setState(() => setState(() => _phoneEmailErrorText = null));
        }
      }
    }
    if(_passwordController.text == '' || _passwordController.text.length <8){
      setState(() => setState(() => _passwordErrorText = 'কমপক্ষে ৮ ডিজিটের পাসওয়ার্ড দিন'));
      return;
    }
    else {
      setState(() => setState(() {
        _passwordErrorText = null;
        _loading = true;
      }));
      if(email != ''){
        loginData = {
          'email' : email,
          'password' : _passwordController.text,
          'device1' : deviceId
        };
        print('valid email: $loginData');
      }else{
        loginData = {
          'phone' : phone,
          'password' : _passwordController.text,
          'device1' : deviceId
        };
        print('valid phone: $loginData');
      }
      await userController.login(loginData).then((userLoginModel) async{
        setState(() => _loading = false);
        if(userLoginModel){
          if(_rememberLogin){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('readOnUserId', userController.userLoginModel.value.userInfo![0].id.toString());
            Get.to(() => const HomePage());
            // ignore: avoid_print
            print('successfully logged in');
          }else{
            Get.offAll(()=> const HomePage());
            // ignore: avoid_print
            print('successfully logged in');
          }
        }else{
          showToast('Login failed! Try again.');
          print('Invalid email, phone or password');
        }
      });
    }

  }
}
