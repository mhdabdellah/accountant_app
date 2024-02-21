import 'dart:async';

import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  final customExceptionHandler = CustomExceptionHandler();

  int currentIndex = 0;

  bool isLoading = true;
  String? errorMessage;

  List<TransactionModel> transactions = [];

  double totalProfit = 0.0;
  double totalExpenses = 0.0;
  double totalIncomes = 0.0;

  String userId = "";

  final int _pageSize = 5;
  int _currentPage = 0;
  int _numberOfPages = 0;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
  int get numberOfPages => _numberOfPages;

  TransactionProvider({
    required this.userId,
  });

  Future<void> fetch({required int pageIndex}) async {
    isLoading = true;
    errorMessage = null;
    final pages = await _transactionService.getNumberOfTransactions(
        pageSize: _pageSize, pageIndex: pageIndex, userId: userId);
    _numberOfPages = pages;

    final start = _currentPage * _pageSize;
    final end = start + _pageSize - 1;

    if (pageIndex == 1) {
      transactions = await _transactionService.fetchAllTransactions(
        start: start,
        end: end,
        userId: userId,
      );
    } else if (pageIndex == 2) {
      transactions = await _transactionService.fetchExpenses(
        start: start,
        end: end,
        userId: userId,
      );
    } else if (pageIndex == 3) {
      transactions = await _transactionService.fetchIncoms(
        start: start,
        end: end,
        userId: userId,
      );
    } else {
      transactions = [];
    }

    _hasMore = _currentPage < pages;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchData({required int pageIndex}) async {
    final response = await customExceptionHandler
        .catchErrors<void>(() => fetch(pageIndex: pageIndex));

    if (response.error != null) {
      errorMessage = response.error!;
      notifyListeners();
    }
  }

  Future<void> loadNextPage({required int pageIndex}) async {
    if (isLoading || !_hasMore) return;
    _currentPage++;
    await fetchData(pageIndex: pageIndex);
  }

  Future<void> loadPreviousPage({required int pageIndex}) async {
    if (isLoading || _currentPage == 0) return;
    _currentPage--;
    await fetchData(pageIndex: pageIndex);
  }

  updateCurrentIndex(int index) async {
    currentIndex = index;
    _currentPage = 0;
    await tranactionsAmounts();
    await fetchData(pageIndex: currentIndex);
    notifyListeners();
  }

  Future<void> closeAndGetStreams() async {
    await tranactionsAmounts();
    await fetchData(pageIndex: currentIndex);
    notifyListeners();
  }

  Future<void> amounts() async {
    isLoading = true;
    updateData(await _transactionService.tranactionsAmounts(userId: userId));
    isLoading = false;

    notifyListeners();
  }

  Future<void> tranactionsAmounts() async {
    final response =
        await customExceptionHandler.catchErrors<void>(() => amounts());

    if (response.error != null) {
      errorMessage = response.error!;
      notifyListeners();
    }
  }

  updateData(List<TransactionModel> transactions) {
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

  @override
  void dispose() {
    transactions = [];
    totalProfit = 0.0;
    totalExpenses = 0.0;
    totalIncomes = 0.0;
    super.dispose();
  }
}
