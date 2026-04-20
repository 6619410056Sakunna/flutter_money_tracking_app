import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/views/money_balance_ui.dart';
import 'package:flutter_money_tracking_app/views/money_in_ui.dart';
import 'package:flutter_money_tracking_app/views/money_out_ui.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  //สร้างตัวแปรควบคุมCurrent Index
  int currentIndexStatus = 1;

  List<Widget> showBody = [
    MoneyInUi(),
    MoneyBalanceUi(),
    MoneyOutUi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 1. ฝั่งซ้าย: แสดงเวลา
        leadingWidth: 80, // เพิ่มความกว้างให้พอสำหรับเวลา
        leading:Center(
          child: Text(
            '9:41',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        actions:[
          Icon(
            Icons.signal_cellular_alt,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Icon(
            Icons.wifi,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Padding(
            padding: EdgeInsets.only(right: 16.0), // เว้นระยะห่างจากขอบจอขวา
            child: Icon(
              Icons.battery_5_bar_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(66, 150, 144, 1),
                Color.fromRGBO(42, 124, 118, 1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => {
          setState(() {
            currentIndexStatus = value;
          }),
        },
        currentIndex: currentIndexStatus,
        backgroundColor: Color.fromRGBO(54, 137, 131, 1),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download_outlined,
              size: 34,
              color: Colors.grey[400],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 50,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_upload_outlined,
              size: 34,
              color: Colors.grey[400],
            ),
            label: '',
          ),
        ],
      ),
      body: showBody[currentIndexStatus],
    );
  }
}
