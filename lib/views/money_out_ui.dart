import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/models/txn.dart';
import 'package:flutter_money_tracking_app/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MoneyOutUi extends StatefulWidget {
  const MoneyOutUi({super.key});

  @override
  State<MoneyOutUi> createState() => _MoneyOutUiState();
}

class _MoneyOutUiState extends State<MoneyOutUi> {
  // สร้างตัวแปรสําหรับจัดรูปแบบ
  final formatter = NumberFormat('#,###.00');
  // สร้างตัวแปรที่จะแสดง
  List<Txn> txns = [];
  //สร้างinstance/object/ตัวแทนของsupabase
  final service = SupabaseService();

  //เพิ่มตัวแปรสำหรับเก็บยอดคำนวณ
  double totalBalance = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  // เพิ่มตัวแปรสำหรับจัดรูปแบบ
  void loadAllTxns() async {
    final data = await service.getTxns();

    // เริ่มคำนวณจากข้อมูลที่ดึงมา
    double income = 0.0;
    double expense = 0.0;

    for (var item in data) {
      if (item.txnType == 'income') {
        // ถ้าประเภทเป็นรายรับ ให้บวกเข้าตัวแปร income
        income += item.txnAmount;
      } else if (item.txnType == 'expense') {
        // ถ้าประเภทเป็นรายจ่าย ให้บวกเข้าตัวแปร expense
        expense += item.txnAmount;
      }
    }

    setState(() {
      txns = data;
      // อัปเดตค่าที่คำนวณได้ลง State
      totalIncome = income;
      totalExpense = expense;
      totalBalance = income - expense; // ยอดคงเหลือ = รับ - จ่าย
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllTxns();
  }

  // วันเวลาปัจจุบัน
  DateTime now = DateTime.now();

  // ตัวควบคุมสำหรับ TextField
  TextEditingController txnTitleCtrl = TextEditingController();
  TextEditingController txnAmountCtrl = TextEditingController();
  // เมธอดสําหรับบันทึกข้อมูล
  void saveTxn() async {
    //validate ข้อมูล
    if (txnTitleCtrl.text.isEmpty || txnAmountCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    // แพ็คข้อมูล
    Txn txn = Txn(
      txnTitle: txnTitleCtrl.text,
      txnAmount: double.parse(txnAmountCtrl.text),
      txnType: 'expense',
      txnDate: now.toString(),
    );
    // ส่งไปที่supabase
    await service.insertTxn(txn);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกข้อมูลเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    // ล้างข้อมูลใน TextField
    txnTitleCtrl.text = '';
    txnAmountCtrl.text = '';
    loadAllTxns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ภาพพื้นหลังและภาพอื่น ๆ ที่ต้องการแสดงแบบซ้อนกัน
          Image.asset(
            'assets/images/Rectangle.png',
            width: MediaQuery.of(context).size.width,
            height: 224,
            fit: BoxFit.fill,
          ),
          // จัดตำแหน่งเรียงภาพซ้อน
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sakunna Sangrutsamee',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  'assets/images/Man.png',
                  width: 62,
                  height: 62,
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
          // ในสี่เหลี่ยม
          Align(
            alignment: Alignment(0, -0.7), // 0 คือกลางแนวนอน
            child: Container(
              width: 374, // ปรับขนาดตามต้องการ
              height: 201,
              decoration: BoxDecoration(
                color: Color.fromRGBO(47, 126, 121, 1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(47, 126, 121, 1).withOpacity(1),
                    blurRadius: 30,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    'ยอดคงเหลือ',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${formatter.format(totalBalance)} ',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_down,
                                  color: Colors.white54,
                                  size: 25,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'ยอดเงินเข้ารวม',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${formatter.format(totalIncome)}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_circle_up,
                                  color: Colors.white54,
                                  size: 25,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'ยอดเงินออกรวม',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${formatter.format(totalExpense)}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top:
                330, // กำหนดให้เริ่มแสดงที่ระยะ 330 จากด้านบน (ปรับตัวเลขนี้ได้ตามความเหมาะสม)
            left: 0,
            right: 0,
            bottom: 0, // ให้กินพื้นที่ไปจนถึงด้านล่างสุดของจอ
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'วันที่ ${DateUtil.thaiDatetoday()}',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(34, 34, 34, 1),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'เงินออก',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(34, 34, 34, 1),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: txnTitleCtrl,
                    decoration: InputDecoration(
                      labelText: 'รายการเงินออก',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'DETAIL',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(47, 126, 121, 0.3),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(47, 126, 121, 1),
                          width: 2.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: txnAmountCtrl,
                    decoration: InputDecoration(
                      labelText: 'จำนวนเงินออก',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(47, 126, 121, 0.3),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(47, 126, 121, 1),
                          width: 2.0,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    ),
                  ),
                  SizedBox(height: 40),
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
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(67, 136, 131, 0.4),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        saveTxn();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        fixedSize: Size(359.0, 59.0),
                      ),
                      child: Text(
                        'บันทึกเงินออก',
                        style: GoogleFonts.inter(
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
        ],
      ),
    );
  }
}
