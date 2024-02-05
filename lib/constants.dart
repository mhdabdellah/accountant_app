import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'models/transaction_model.dart';

const String supabaseProjectURL = "https://mcbnbrbjykfcrpyvhxpz.supabase.co";
const String supabaseApiKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1jYm5icmJqeWtmY3JweXZoeHB6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcxMzY4NDAsImV4cCI6MjAyMjcxMjg0MH0.BGUSiAdytpeRnb9rG7r3JY3phF4LzD_1G7hKTuK3eKQ";

// client for supabase
final client = Supabase.instance.client;

List<TransactionModel> transactionsFromJson(String str) =>
    List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)));
