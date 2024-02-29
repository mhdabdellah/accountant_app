import 'dart:async';

import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

abstract class MainProvider extends ChangeNotifier {
  final TransactionService transactionService = TransactionService();

  final exceptionHandler = ExceptionHandler();
  final currentUserProvider = CurrentUserProvider();

  bool isLoading = true;
  String? errorMessage;

  double totalProfit = 0.0;
  double totalExpenses = 0.0;
  double totalIncomes = 0.0;

  final int pageSize = 5;
  int currentPage = 0;
  int numberOfPages = 0;
  bool hasMore = true;

  late final StreamSubscription<List<TransactionModel>> transactionSubscription;

  List<TransactionModel> allTransactions = [];
  List<TransactionModel> allExpenses = [];
  List<TransactionModel> allIncomes = [];

  List<TransactionModel> paginatedTransactions = [];
  List<TransactionModel> paginatedExpenses = [];
  List<TransactionModel> paginatedIncomes = [];

  Future<void> fetchData();
  // Function to perform pagination
  List<TransactionModel> paginateTransactions(int start, int end);

  void init() {
    // isLoading = true;
    getTransactionsStream();
    fetchData();
    // isLoading = false;
    // notifyListeners();
  }

  void cancelAndgetTransactionsStream() {
    // isLoading = true;
    transactionSubscription.cancel();
    getTransactionsStream();
    fetchData();
    // isLoading = false;
    // notifyListeners();
  }

  void getTransactionsStream() {
    isLoading = true;
    transactionSubscription = transactionService
        .transactionStream(userId: currentUserProvider.currentUserId)
        .listen(
      (onTransactionsReceived) {
        allTransactions = onTransactionsReceived;
        updateData(allTransactions);
        isLoading = false;
        notifyListeners();
      },
      onError: (err) {
        errorMessage = err.toString();
      },
    );
  }

  Future<void> loadNextPage() async {
    if (isLoading || !hasMore) return;
    currentPage++;
    await fetchData();
  }

  Future<void> loadPreviousPage() async {
    if (isLoading || currentPage == 0) return;
    currentPage--;
    await fetchData();
  }

  // Future<void> amounts() async {
  //   isLoading = true;
  //   List<TransactionModel> transactionList = await transactionService
  //       .tranactionsAmounts(userId: currentUserProvider.currentUserId);
  //   updateData(transactionList);
  //   isLoading = false;

  //   notifyListeners();
  // }

  // Future<void> tranactionsAmounts() async {
  //   final response = await exceptionHandler.exceptionCatcher<void>(
  //       function: () => amounts(), showSnackbar: false);

  //   if (response.isError) {
  //     errorMessage = response.error!;
  //     notifyListeners();
  //   }
  // }

  updateData(List<TransactionModel> transactions) {
    totalExpenses = 0.0;
    totalIncomes = 0.0;
    allExpenses = [];
    allIncomes = [];
    allTransactions = transactions;
    notifyListeners();
    for (TransactionModel transaction in transactions) {
      if (transaction.isExpense) {
        totalExpenses += transaction.amount;
        allExpenses.add(transaction);
        notifyListeners();
      } else {
        totalIncomes += transaction.amount;
        allIncomes.add(transaction);
        notifyListeners();
      }
    }
    totalProfit = totalIncomes - totalExpenses;

    notifyListeners();
  }

  @override
  void dispose() {
    transactionSubscription.cancel();
    super.dispose();
  }
}
