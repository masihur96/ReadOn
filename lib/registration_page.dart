import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/login_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/public_variables/text_field_validation.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:read_on/widgets/custom_loading.dart';
import 'package:read_on/widgets/custom_text_form_field.dart';
import 'package:read_on/widgets/gradient_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _phoneNoController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text: '');
  final TextEditingController _confirmPasswordController = TextEditingController(text: '');

  String? _nameErrorText;
  String? _emailErrorText;
  String? _phoneNoErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;

  bool _passwordObscureText = true;
  bool _confirmPasswordObscureText = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    final double size = publicController.size.value;
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
                color: Colors.black12,
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
        SizedBox(
          width: Get.width,
          height: size*1.8,
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

              /// name, email, phone, password input fields
              Positioned(
                top: size*.6,
                child: Container(
                  width: size*.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(size * .2),
                          topRight: Radius.circular(size * .07),
                          bottomLeft: Radius.circular(size * .07),
                          bottomRight: Radius.circular(size * .07))
                  ),
                  padding: EdgeInsets.fromLTRB(size*.1, size*.3, size*.1, size*.04),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        size: size,
                        textEditingController: _nameController,
                        hintText: 'Username',
                        errorText: _nameErrorText,
                        obscureText: false,
                        suffix: null,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: size * .01),
                      Divider(
                        color: const Color(0xffD4D4D4),
                        thickness: size*.007,
                        height: size*.01,
                      ),
                      SizedBox(height: size * .01),
                      CustomTextFormField(
                        size: size,
                        textEditingController: _emailController,
                        hintText: 'Email',
                        errorText: _emailErrorText,
                        obscureText: false,
                        suffix: null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: size * .01),
                      Divider(
                        color: const Color(0xffD4D4D4),
                        thickness: size*.007,
                        height: size*.01,
                      ),
                      SizedBox(height: size * .01),
                      CustomTextFormField(
                        size: size,
                        textEditingController: _phoneNoController,
                        hintText: 'Phone',
                        errorText: _phoneNoErrorText,
                        obscureText: false,
                        suffix: null,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: size * .01),
                      Divider(
                        color: const Color(0xffD4D4D4),
                        thickness: size*.007,
                        height: size*.01,
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
                            setState(
                                    () => _passwordObscureText = !_passwordObscureText);
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
                      Divider(
                        color: const Color(0xffD4D4D4),
                        thickness: size*.007,
                        height: size*.01,
                      ),
                      SizedBox(height: size * .01),
                      CustomTextFormField(
                        size: size,
                        textEditingController: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        errorText: _confirmPasswordErrorText,
                        obscureText: _confirmPasswordObscureText,
                        suffix: InkWell(
                          onTap: () {
                            setState(() => _confirmPasswordObscureText =
                            !_confirmPasswordObscureText);
                          },
                          child: Icon(
                            _confirmPasswordObscureText
                                ? LineAwesomeIcons.eye
                                : LineAwesomeIcons.eye_slash,
                            color: const Color(0xff98989A),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size*.38,
                child: Container(
                  width: size*.35, height: size*.35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(3, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(size*.07),
                  child: Image.asset('assets/logo_with_name.png')
                ),
              )
            ],
          ),
        ),

        /// sign up button
        SizedBox(
          width: size*.8,
          height: size*.12,
          child: GradientButton(
              child: Text(
                'Sign up',
                style: Style.buttonTextStyle(
                    size * .05, Colors.white, FontWeight.w500),
              ),
              onPressed: ()  {
                _registerUser(userController);
              },
              borderRadius: size * .01,
              height: size * .12,
              width: double.infinity,
              gradientColors: const [CColor.themeColor, CColor.themeColorLite]),
        ),
        SizedBox(height: size*.04,),
        Text(
          'or connect with',
          style: Style.bodyTextStyle(size*.04, Colors.black, FontWeight.w500),
        ),
        SizedBox(height: size*.04,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size*.08),
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
                    border: Border.all(color: const Color(0xffC8C8C8))
                  ),
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
        SizedBox(height: size*.04,),
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
                          Get.to(() => LoginPage());
                        },
                      text: 'Login here',
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.w500)),
                ])),
        SizedBox(height: size*.08,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.08),
          child: Divider(
            thickness: size*.01,
            color: const Color(0xffD4D4D4),
            height: size*.01,
          ),
        ),
        SizedBox(height: size*.02,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.08),
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
                          ..onTap = () {},
                        text: 'Terms & Condition',
                        style: Style.bodyTextStyle(
                            size * .04, CColor.themeColorLite, FontWeight.w500)),
                    const TextSpan(
                      text: ' , ',
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {},
                        text: 'Privacy Policy',
                        style: Style.bodyTextStyle(
                            size * .04, CColor.themeColorLite, FontWeight.w500)),
                  ])),
        ),
        SizedBox(height: size*.1,),
      ],
    ),
  );

  void _registerUser(UserController userController) async {
    if (!nameValidation(_nameController.text)) {
      setState(() => _nameErrorText = 'আপনার নাম লিখুন');
      return;
    } else {
      setState(() => _nameErrorText = null);
    }
    if (!emailValidation(_emailController.text)) {
      setState(() => _emailErrorText = 'আপনার সঠিক ইমেইলটি লিখুন');
      return;
    } else {
      setState(() => _emailErrorText = null);
    }
    if (!phoneNoValidation(_phoneNoController.text)) {
      setState(
          () => _phoneNoErrorText = 'আপনার ১১ ডিজিটের মোবাইলটি নম্বর লিখুন');
      return;
    } else {
      setState(() => _phoneNoErrorText = null);
    }
    if (!passWordValidation(_passwordController.text)) {
      setState(() => _passwordErrorText = 'কমপক্ষে ৮ ডিজিটের পাসওয়ার্ড দিন');
      return;
    } else {
      setState(() => _passwordErrorText = null);
    }
    if (!confirmPasswordValidation(
        _passwordController.text, _confirmPasswordController.text)) {
      setState(() => _confirmPasswordErrorText = 'পাসওয়ার্ড মিলছে না');
      return;
    } else {
      setState(() => _confirmPasswordErrorText = null);
    }
    setState(() => _loading = true);
    Map userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'phone': _phoneNoController.text
    };
    bool isSuccessful = await userController.registerUser(userData);
    setState(() => _loading = false);
    if(isSuccessful) {
      showToast('Successfully registered!');
      Get.offAll(() => LoginPage());
    } else {
      showToast('Registration Failed!');
    }
  }
}
