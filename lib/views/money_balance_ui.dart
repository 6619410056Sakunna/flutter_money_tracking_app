import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_money_tracking_app/models/txn.dart';
import 'package:flutter_money_tracking_app/services/supabase_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MoneyBalanceUi extends StatefulWidget {
  const MoneyBalanceUi({super.key});

  @override
  State<MoneyBalanceUi> createState() => _MoneyBalanceUiState();
}

class _MoneyBalanceUiState extends State<MoneyBalanceUi> {
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
  DateTime now = DateTime.now();

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
                  style: GoogleFonts.inter(
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
          // ส่วนรายการเงินเข้า/เงินออก (แก้ไขจาก Align เป็น Positioned)
          Positioned(
            top:
                330, // กำหนดให้เริ่มแสดงที่ระยะ 330 จากด้านบน (ปรับตัวเลขนี้ได้ตามความเหมาะสม)
            left: 0,
            right: 0,
            bottom: 0, // ให้กินพื้นที่ไปจนถึงด้านล่างสุดของจอ
            child: Column(
              children: [
                Text(
                  'เงินเข้า/เงินออก',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(34, 34, 34, 1),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: txns.length,
                    itemBuilder: (context, index) {
                      final item = txns[index];
                      bool isIncome = item.txnType == 'income';
                      return Padding(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          // iconด้านซ้ายเขียวแดง
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isIncome ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isIncome
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          // ข้อความรายการ
                          title: Text(
                            item.txnTitle,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Color.fromRGBO(34, 34, 34, 1),
                            ),
                          ),
                          // ข้อความวันที่
                          subtitle: Text(
                            DateUtil.thaiDatedata(item.txnDate),
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          // จำนวนเงินด้านขวา
                          trailing: Text(
                            // ถ้าเป็นรายรับให้โชว์เครื่องหมาย + ถ้ารายจ่ายโชว์ - ตามด้วยจำนวนเงิน
                            "${formatter.format(item.txnAmount)}",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              // สีของตัวเลข: รายรับสีเขียว / รายจ่ายสีแดง
                              color: isIncome ? Colors.green : Colors.red,
                            ),
                          ),
                          shape: Border(
                            // ขอบบน
                            top: BorderSide(
                              color: Color.fromRGBO(34, 34, 34, 0.1),
                              width: 1,
                            ),
                            // ขอบล่าง
                            bottom: BorderSide(
                              color: Color.fromRGBO(34, 34, 34, 0.1),
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
