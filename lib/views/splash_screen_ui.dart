import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/views/welcome_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeUi()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(99, 181, 175, 1),
              Color.fromRGBO(67, 136, 131, 1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300),
            Text(
              'Money Tracking ',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'รายรับรายจ่ายของฉัน',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 300),
            Text(
              'Created by 6619410056',
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '-SAU-',
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
