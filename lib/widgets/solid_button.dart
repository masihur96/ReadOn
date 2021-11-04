import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SolidColorButton extends StatelessWidget {
  Function() onPressed;
  Widget child;
  Color bgColor;
  double? borderRadius;
  EdgeInsetsGeometry? contentPadding;
  SolidColorButton(
      {Key? key, required this.child,
        required this.onPressed,
        required this.bgColor,this.borderRadius,this.contentPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius??4.0)),
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius??4.0)),
          child: Padding(
              padding: contentPadding?? const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              child: child),
        )
    );
  }
}
