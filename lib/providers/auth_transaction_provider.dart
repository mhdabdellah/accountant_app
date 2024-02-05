import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/models/user_model.dart';
import 'package:accountant_app/services/auth_service.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class AuthTransactionProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TransactionService _transactionService = TransactionService();
  UserModel? currentUser;

  List<TransactionModel> transactions = [];

  Future<void> signIn(String email, String password) async {
    currentUser = await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    currentUser = await _authService.signUp(name, email, password);
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    transactions = await _transactionService.getAllTransactions();
    notifyListeners();
  }

  Future<void> getExpenses() async {
    transactions = await _transactionService.getExpenses();
    notifyListeners();
  }

  Future<void> getIncomes() async {
    transactions = await _transactionService.getIncomes();
    notifyListeners();
  }

  Future<void> getTransactionsInDateRange(
      DateTime startDate, DateTime endDate) async {
    transactions = await _transactionService.getTransactionsInDateRange(
        startDate: startDate, endDate: endDate);
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    _transactionService.addTransaction(transaction: transaction);
    getAllTransactions();
  }

  void deleteTransanction(String transactionId) {
    _transactionService.deleteTransaction(id: transactionId);
    getAllTransactions();
  }
}
