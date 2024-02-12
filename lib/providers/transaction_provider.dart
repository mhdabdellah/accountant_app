import 'dart:async';

import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  int currentIndex = 0;

  bool isloaded = true;

  List<TransactionModel> transactions = [];
  List<TransactionModel> expenses = [];
  List<TransactionModel> incomes = [];

  double totalProfit = 0.0;
  double totalExpenses = 0.0;
  double totalIncomes = 0.0;

  late final StreamSubscription<List<TransactionModel>>
      _transactionSubscription;

  TransactionProvider() {
    getAllTransactionsStream();
  }

  updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  getAllTransactionsStream() {
    _transactionSubscription = _transactionService.transactionsStream().listen(
      (onTransactionsReceived) {
        isloaded = false;
        transactions = onTransactionsReceived;
        isloaded = true;
        updateData(transactions);
        notifyListeners();
      },
      onError: (err) {
        print("error");
      },
    );
  }

  updateData(List<TransactionModel> transactions) {
    totalExpenses = 0.0;
    totalIncomes = 0.0;
    expenses = [];
    incomes = [];
    for (TransactionModel transaction in transactions) {
      if (transaction.isExpense) {
        totalExpenses += transaction.amount;
        expenses.add(transaction);
      } else {
        totalIncomes += transaction.amount;
        incomes.add(transaction);
      }
    }
    totalProfit = totalIncomes - totalExpenses;
    expenses.sort((a, b) => b.date.compareTo(a.date));
    incomes.sort((a, b) => b.date.compareTo(a.date));

    notifyListeners();
  }

  Future<bool> addTransaction(
      {required String title,
      required double amount,
      required bool isExpense}) async {
    isloaded = false;
    DateTime date = DateTime.now();
    String? userId = client.auth.currentSession?.user.id;
    final transaction = TransactionModel(
      title: title,
      amount: amount,
      isExpense: isExpense,
      date: date,
      userId: userId ?? "",
    );
    bool response =
        await _transactionService.addTransaction(transaction: transaction);
    isloaded = true;
    notifyListeners();
    return response;
  }

  @override
  void dispose() {
    _transactionSubscription.cancel();
    transactions = [];
    expenses = [];
    incomes = [];
    super.dispose();
  }
}