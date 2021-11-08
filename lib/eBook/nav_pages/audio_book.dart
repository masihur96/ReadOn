import 'package:flutter/material.dart';

class AudioBookPage extends StatefulWidget {
  const AudioBookPage({Key? key}) : super(key: key);

  @override
  _AudioBookPageState createState() => _AudioBookPageState();
}

class _AudioBookPageState extends State<AudioBookPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Audio book')),
    );
  }
}

