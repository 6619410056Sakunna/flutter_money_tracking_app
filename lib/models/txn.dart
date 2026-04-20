class Txn {
  String? id;
  String txnTitle;
  double txnAmount;
  String txnType;
  String txnDate;

  Txn({
    this.id,
    required this.txnTitle,
    required this.txnAmount,
    required this.txnType,
    required this.txnDate,
  });

  // แปลงข้อมูลจาก supabase มาใช้ (อิงตามชื่อตัวแปรหลัก)
  factory Txn.fromJson(Map<String, dynamic> json) {
    return Txn(
      id: json['id'],
      txnTitle: json['txnTitle'],
      txnAmount: (json['txnAmount'] as num).toDouble(),
      txnType: json['txnType'],
      txnDate: json['txnDate'],
    );
  }

  // แปลงข้อมูลจากแอปไปเก็บ supabase
  Map<String, dynamic> toJson() {
    return {
      'txnTitle': txnTitle,
      'txnAmount': txnAmount,
      'txnType': txnType,
      'txnDate': txnDate,
    };
  }
}

class DateUtil {
  // แปลงวันที่จาก String ในฐานข้อมูลเป็นไทย
  static String thaiDatedata(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return _formatThai(date);
  }

  // ดึงวันที่ปัจจุบัน
  static String thaiDatetoday() {
    return _formatThai(DateTime.now());
  }

  static String _formatThai(DateTime date) {
    List<String> months = [
      "มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน",
      "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม"
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year + 543}";
  }
}

