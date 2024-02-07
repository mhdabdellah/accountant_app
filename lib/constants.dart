import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/transaction_model.dart';

const String supabaseProjectURL = "https://mcbnbrbjykfcrpyvhxpz.supabase.co";
const String supabaseApiKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1jYm5icmJqeWtmY3JweXZoeHB6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcxMzY4NDAsImV4cCI6MjAyMjcxMjg0MH0.BGUSiAdytpeRnb9rG7r3JY3phF4LzD_1G7hKTuK3eKQ";

// client for supabase
final client = Supabase.instance.client;

const primaryColor = Color(0x00f8fafc);

List<TransactionModel> transactionsFromJson(List<dynamic> jsonData) {
  // String jsonString =
  //     '[{"id": "54729e10-d5e0-42b1-b1e8-91d92b2e1512", "created_at": "2024-02-05T18:25:14.078762+00:00", "title": "yghjj", "amount": 26666, "isExpense": true, "date": "2024-02-05T18:10:01.932601"}, {"id": "a4af729e-c5a6-4cad-97c8-401fc9ec3b45", "created_at": "2024-02-05T18:26:24.308271+00:00", "title": "yghjj", "amount": 26666, "isExpense": true, "date": "2024-02-05T18:10:01.932601"}, {"id": "bd33bdc8-18b6-41bf-86ba-37861f3b927e", "created_at": "2024-02-05T18:26:25.214047+00:00", "title": "yghjj", "amount": 26666, "isExpense": true, "date": "2024-02-05T18:10:01.932601"}]';
  // List<dynamic> jsonData = jsonDecode(jsonString);
  List<TransactionModel> transactionModels =
      jsonData.map((json) => TransactionModel.fromJson(json)).toList();
  // print(transactionModels);
  return transactionModels;
}
