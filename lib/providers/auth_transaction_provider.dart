import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class AuthTransactionProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TransactionService _transactionService = TransactionService();
  UserModel? currentUser;
  bool isloaded = true;

  List<TransactionModel> transactions = [];

  double totalProfit = 0.0;
  double totalExpenses = 0.0;
  double totalIncomes = 0.0;

  Future<void> signIn(String email, String password) async {
    currentUser = await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    currentUser = await _authService.signUp(name, email, password);
    notifyListeners();
  }

  getTotalAmounts(List<TransactionModel> transactions) {
    totalProfit = 0.0;
    totalExpenses = 0.0;
    totalIncomes = 0.0;

    for (TransactionModel transaction in transactions) {
      if (transaction.isExpense) {
        totalExpenses += transaction.amount;
      } else {
        totalIncomes += transaction.amount;
      }
    }
    totalProfit = totalIncomes - totalExpenses;
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    isloaded = false;
    transactions = await _transactionService.getAllTransactions();
    isloaded = true;
    getTotalAmounts(transactions);
    notifyListeners();
  }

  Future<void> getExpenses() async {
    isloaded = false;
    transactions = await _transactionService.getExpenses();
    isloaded = true;
    notifyListeners();
  }

  Future<void> getIncomes() async {
    isloaded = false;
    transactions = await _transactionService.getIncomes();
    isloaded = true;
    notifyListeners();
  }

  Future<void> getTransactionsInDateRange(
      DateTime startDate, DateTime endDate) async {
    isloaded = false;
    transactions = await _transactionService.getTransactionsInDateRange(
        startDate: startDate, endDate: endDate);
    isloaded = true;
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    isloaded = false;
    _transactionService.addTransaction(transaction: transaction);
    getAllTransactions();
    isloaded = true;
  }
}
