import 'package:flutter/material.dart';

class AccountPageAll extends StatelessWidget {
  const AccountPageAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Page'),
        ),
      ),
    );
  }
}
