import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  String routeName = '/admin_homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Center(
        child: Text('Welcome Admin!'),
      ),
    );
  }
}
