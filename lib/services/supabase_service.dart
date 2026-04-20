import 'package:flutter_money_tracking_app/models/txn.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // ดึงข้อมูลจากตาราง txn_tb
  Future<List<Txn>> getTxns() async {
    final data = await supabase
        .from('txn_tb')
        .select('*')
        .order('txnDate', ascending: false);

    return data.map<Txn>((e) => Txn.fromJson(e)).toList();
  }

  // เพิ่มข้อมูล
  Future<void> insertTxn(Txn txn) async {
    await supabase.from('txn_tb').insert(txn.toJson());
  }
}
