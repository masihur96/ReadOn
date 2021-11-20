import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitDualRing(
      color: Colors.red,
      size: 45.0,
      lineWidth: 5,
    );
  }
}
