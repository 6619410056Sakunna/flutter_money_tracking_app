import 'package:flutter/material.dart';

class MoneyInUi extends StatefulWidget {
  const MoneyInUi({super.key});

  @override
  State<MoneyInUi> createState() => _MoneyInUiState();
}

class _MoneyInUiState extends State<MoneyInUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Money In Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}