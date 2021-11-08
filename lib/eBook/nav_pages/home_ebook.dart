import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';

class HomePageEbook extends StatefulWidget {
  const HomePageEbook({Key? key}) : super(key: key);

  @override
  State<HomePageEbook> createState() => _HomePageEbookState();
}

class _HomePageEbookState extends State<HomePageEbook> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Home')),
    );
  }
}
