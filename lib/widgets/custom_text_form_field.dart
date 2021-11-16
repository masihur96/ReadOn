import 'package:flutter/material.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class CustomTextFormField extends StatelessWidget {
  double size;
  TextEditingController textEditingController;
  String hintText;
  IconData? prefixIcon;
  String? errorText;
  bool obscureText;
  Widget? suffix;
  TextInputType keyboardType;

  CustomTextFormField(
      {Key? key,
      required this.size,
      required this.textEditingController,
      required this.hintText,
      required this.prefixIcon,
      required this.errorText,
      required this.obscureText,
      required this.suffix,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      cursorColor: Colors.black,
      autofocus: false,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Style.bodyTextStyle(size * .04, Colors.grey, FontWeight.normal),
        contentPadding: EdgeInsets.symmetric(horizontal: size * .045, vertical: size * .02),
        prefixIcon: Icon(prefixIcon, color: Colors.grey,),
        suffixIcon: suffix,
        errorText: errorText,
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
        border:  OutlineInputBorder(
          borderSide:  const BorderSide(color: CColor.greyColor),
          borderRadius: BorderRadius.circular(size*.01)
        ),
        enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: CColor.greyColor),
            borderRadius: BorderRadius.circular(size*.01)
        ),
        focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: CColor.themeColor),
            borderRadius: BorderRadius.circular(size*.01)
        ),
        disabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: CColor.greyColor),
            borderRadius: BorderRadius.circular(size*.01)
        ),
      ),
    );
  }
}
