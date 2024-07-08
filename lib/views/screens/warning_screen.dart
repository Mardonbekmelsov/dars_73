import 'package:flutter/material.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "Joylashuvga ruxsat bermasangiz ilova funksiyalari ishlamaydi"
            " iltimos joylashuvga ruxsat berib ilovani qayta ishga tushiring",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}