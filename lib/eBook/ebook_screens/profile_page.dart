import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/ebook_screens/edit_profile.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/model/user_model.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  TextEditingController _institutionController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  int _count = 0;
  List<UserModel> _userModel = [];
  bool _loading = false;

  void _customInit(UserController userController) async {
    _count++;
    setState(() {
      _loading = true;
    });
    await userController
        .getUserInfo(userController.userLoginModel.value.userInfo![0].id!);
    setState(() {
      _userModel = userController.userModelList;
    });
    fillUserInfo(userController);
    setState(() {
      _loading = false;
    });
  }

  void fillUserInfo(UserController userController) {
    setState(() {
      _nameController.text = _userModel[0].name!;
      _emailController.text = _userModel[0].email!;
      _mobileNoController.text = _userModel[0].phone!;
      _userModel[0].dateOfBirth == null
          ? _birthDateController.text = ""
          : _birthDateController.text = _userModel[0].dateOfBirth;
      _userModel[0].institution == null
          ? _institutionController.text = ""
          : _institutionController.text = _userModel[0].institution;
      _userModel[0].division == null
          ? _divisionController.text = ""
          : _divisionController.text = _userModel[0].division;
      _userModel[0].gender == null
          ? _genderController.text = ""
          : _genderController.text = _userModel[0].gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    double size = publicController.size.value;
    if (_count == 0) _customInit(userController);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => _loading
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
                        children: [
                          SizedBox(
                            width: size,
                            height: size * .42,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -size * .65,
                                  left: -size * .2,
                                  child: Container(
                                    width: size,
                                    height: size,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffEAEAEA),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -size * .1,
                                  left: size * .33,
                                  child: Container(
                                    width: size * .33,
                                    height: size * .33,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size * .17,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size * .04,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .06),
                            child: Container(
                              width: size,
                              height: size * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size * .03),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        )
      : Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: size,
                  height: size * .42,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -size * .62,
                        left: -size * .2,
                        child: Container(
                          width: size,
                          height: size,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEAEAEA),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -size * .1,
                        left: size * .33,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: size * .012)),

                              /// profile image
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: size * .15,
                                backgroundImage: const AssetImage(
                                    'assets/default_profile_image.png'),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size * .15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child: _customTextFormField(size, _nameController, 'নাম'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child: _customTextFormField(size, _emailController, 'ইমেইল'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child:
                      _customTextFormField(size, _mobileNoController, 'মোবাইল'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child:
                      _customTextFormField(size, _birthDateController, 'জন্ম'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child: _customTextFormField(
                      size, _institutionController, 'স্কুল/কলেজ/বিশ্ববিদ্যালয়'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child: _customTextFormField(
                      size, _divisionController, 'বিভাগ/বিষয়'),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size * .06),
                  child: _customTextFormField(size, _genderController, 'লিঙ্গ'),
                ),
                SizedBox(
                  height: size * .15,
                ),
              ],
            ),
          ),
        );

  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "প্রোফাইল",
        iconData: LineAwesomeIcons.arrow_left,
        action: [
          InkWell(
              onTap: () {
                Get.to(() => EditProfile());
              },
              child: const Icon(
                FontAwesomeIcons.pencilAlt,
                color: Colors.white,
              ))
        ],
        scaffoldKey: _scaffoldKey,
      );

  /// profile info field demo
  Widget _customTextFormField(
          double size, TextEditingController controller, String hintText) =>
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              enabled: false,
              style: Style.bodyTextStyle(
                  size * .045, Colors.black, FontWeight.normal),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: size * .02, horizontal: size * .04),
                labelText: hintText,
                labelStyle: Style.bodyTextStyle(
                    size * .04, const Color(0xff7F7F7F), FontWeight.normal),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .03),
                    borderSide: const BorderSide(color: Colors.black)),
              ),
            ),
          ),
        ],
      );
}
