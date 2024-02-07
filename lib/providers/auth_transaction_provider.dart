import 'package:accountant_app/constants.dart';
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

  void initPage(int pageIndex) {
    if (pageIndex == 1) {
      getAllTransactions();
    } else if (pageIndex == 2) {
      getExpenses();
    } else if (pageIndex == 3) {
      getIncomes();
    }
  }

  Future<bool> signIn(String email, String password) async {
    bool loginResult = await _authService.signIn(email, password);
    if (loginResult == true && client.auth.currentSession?.user != null) {
      currentUser = await _authService
          .getCurrentUser(client.auth.currentSession?.user.id ?? "");
    }
    notifyListeners();
    return loginResult;
  }

  Future<bool> signUp(String firstnameController, String lastnameController,
      String email, String password) async {
    bool registerResult = await _authService.signUp(
        firstnameController, lastnameController, email, password);
    notifyListeners();
    return registerResult;
  }

  Future<bool> logOut() async {
    bool result = await _authService.signOut();
    notifyListeners();
    return result;
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
    getTotalAmounts(transactions);
    isloaded = true;
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
}
