import 'package:flutter/material.dart';

class MoneyOutUi extends StatefulWidget {
  const MoneyOutUi({super.key});

  @override
  State<MoneyOutUi> createState() => _MoneyOutUiState();
}

class _MoneyOutUiState extends State<MoneyOutUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Money Out Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}