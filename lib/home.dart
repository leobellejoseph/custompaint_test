import 'package:custompaint_test/button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(title: const Text('Custom Painter')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Button(),
        ),
      ),
    );
  }
}
