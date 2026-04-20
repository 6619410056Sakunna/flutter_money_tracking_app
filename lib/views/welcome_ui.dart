import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/views/home_ui.dart';

class WelcomeUi extends StatefulWidget {
  const WelcomeUi({super.key});

  @override
  State<WelcomeUi> createState() => _WelcomeUiState();
}

class _WelcomeUiState extends State<WelcomeUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // ภาพพื้นหลังและภาพอื่น ๆ ที่ต้องการแสดงแบบซ้อนกัน
              Stack(
                children: [
                  Image.asset(
                    'assets/images/Group_2.png',
                    width: 500,
                    height: 600,
                    fit: BoxFit.fill,
                  ),
                  // จัดตำแหน่งเรียงภาพวซ้อน
                  Positioned(
                    top: 126.91,
                    left: -60,
                    child: Image.asset(
                      alignment: Alignment.center,
                      'assets/images/Group_1.png',
                      width: 524.14,
                      height: 486.09,
                    ),
                  ),
                  Positioned(
                    top: 104,
                    left: 15,
                    child: Transform.rotate(
                      // หมุนภาพ
                      angle: 0.1, // เรเดียน = องค์ศา*(π/180)
                      child: Image.asset(
                        'assets/images/Coint.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 230,
                    child: Transform.rotate(
                      // หมุนภาพ
                      angle: -0.1, // เรเดียน = องค์ศา*(π/180)
                      child: Image.asset(
                        'assets/images/Donut.png',
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'บันทึก\nรายรับรายจ่าย',
                style: TextStyle(
                  fontSize: 36,
                  color: Color.fromRGBO(67, 136, 131, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                width: 359.0,
                height: 59.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(99, 181, 175, 1),
                      Color.fromRGBO(67, 136, 131, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // นำทางไปยังหน้าหลักของแอปพลิเคชัน
                   Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeUi()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    fixedSize: Size(359.0, 59.0),
                  ),
                  child: Text(
                    'เริ่มใช้งานแอปพลิเคชัน',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
