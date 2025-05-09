import 'dart:async';
import 'dart:math';

import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/base_transactions_services.dart';
import 'package:flutter/material.dart';

abstract class BaseTransactionsProvider extends ChangeNotifier {
  BaseTransactionsServices get transactionService;
  // void fetchTransactions();
  final exceptionHandler = ExceptionHandler();

  bool isLoading = true;
  String? errorMessage;

  // double totalProfit = 0.0;
  // double totalExpenses = 0.0;
  // double totalIncomes = 0.0;

  final int pageSize = 5;
  int currentPage = 0;
  // int numberOfPages = 0;
  bool hasMore = true;

  int get numberOfPages {
    final numberOfTransactions = transactions.length;
    if (numberOfTransactions == 0) {
      return numberOfTransactions;
    } else {
      if (numberOfTransactions % pageSize == 0) {
        return numberOfTransactions ~/ pageSize - 1;
      } else {
        return numberOfTransactions ~/ pageSize;
      }
    }
  }

  // StreamSubscription<List<TransactionModel>>? transactionSubscription;

  List<TransactionModel> transactions = [];

  List<TransactionModel> paginatedTransactions = [];

  BaseTransactionsProvider() {
    initData();
  }

  Future<void> fetchTransactions() async {
    transactions = await transactionService.fetchTransactions();
    notifyListeners();
  }

  Future<void> _fetch() async {
    isLoading = true;
    errorMessage = null;

    final start = currentPage * pageSize;
    final end = start + pageSize;

    paginatedTransactions = paginateTransactions(start, end);

    hasMore = currentPage < numberOfPages;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchData() async {
    final response = await exceptionHandler.exceptionCatcher<void>(
        function: () => _fetch(), showSnackbar: false);

    if (response.isError) {
      errorMessage = response.error!;
      notifyListeners();
    }
  }

  List<TransactionModel> paginateTransactions(int start, int end) {
    if (start < 0) {
      throw ArgumentError('Invalid start and end values.');
    }

    // Ensure end does not exceed the length of the list
    end = min(end, transactions.length);

    return transactions.sublist(start, end);
  }

  Future<void> initData() async {
    isLoading = true;

    await fetchTransactions();
    await fetchData();
    isLoading = false;

    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (isLoading || !hasMore) return;
    currentPage++;
    fetchData();
  }

  Future<void> loadPreviousPage() async {
    if (isLoading || currentPage == 0) return;
    currentPage--;
    fetchData();
  }

  @override
  void dispose() {
    // transactionSubscription?.cancel();
    super.dispose();
  }
}
