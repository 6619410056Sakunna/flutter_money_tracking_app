import 'package:flutter/material.dart';

class MoneyBalanceUi extends StatefulWidget {
  const MoneyBalanceUi({super.key});

  @override
  State<MoneyBalanceUi> createState() => _MoneyBalanceUiState();
}

class _MoneyBalanceUiState extends State<MoneyBalanceUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Money Balance Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}