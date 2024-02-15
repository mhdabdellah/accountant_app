import 'dart:async';

import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  final customExceptionHandler = CustomExceptionHandler();
  int currentIndex = 0;

  int loadingData = 0; // 0 isloading , 1 isloaded, -1 errorOrException

  BuildContext context;

  List<TransactionModel> transactions = [];

  double totalProfit = 0.0;
  double totalExpenses = 0.0;
  double totalIncomes = 0.0;

  String userId = "";

  final int _pageSize = 6;
  int _currentPage = 0;
  bool _hasMore = true;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  late StreamSubscription<List<TransactionModel>> transactionSubscription;

  TransactionProvider({required this.userId, required this.context}) {
    getAllTransactionsStream(userId: userId);
  }

  Future<bool> nextTransactionsList(
      {required int pageIndex, required int start, required int end}) async {
    final nextStart = (_currentPage + 1) * _pageSize;
    final nextEnd = nextStart + _pageSize - 1;
    List<TransactionModel> nextTransactions =
        await _transactionService.fetchTransactions(
      pageSize: _pageSize,
      start: nextStart,
      end: nextEnd,
      userId: userId,
      pageIndex: pageIndex,
    );
    return nextTransactions.isNotEmpty;
  }

  Future<void> fetchData({required int pageIndex}) async {
    try {
      loadingData = 0;

      final start = _currentPage * _pageSize;
      final end = start + _pageSize - 1;

      transactions = await _transactionService.fetchTransactions(
        pageSize: _pageSize,
        start: start,
        end: end,
        userId: userId,
        pageIndex: pageIndex,
      );

      loadingData = 1;
      bool nextIsNotEmpty = await nextTransactionsList(
          pageIndex: pageIndex, start: start, end: end);
      _hasMore = transactions.length == _pageSize && nextIsNotEmpty;
      loadingData = 1;
      notifyListeners();
    } on Exception catch (error) {
      loadingData = -1;
      customExceptionHandler.handleException(context, error);
      notifyListeners();
    }
  }

  Future<void> loadNextPage({required int pageIndex}) async {
    if (loadingData == 0 || !_hasMore) return;
    _currentPage++;
    await fetchData(pageIndex: pageIndex);
  }

  Future<void> loadPreviousPage({required int pageIndex}) async {
    if (loadingData == 0 || _currentPage == 0) return;
    _currentPage--;
    await fetchData(pageIndex: pageIndex);
  }

  updateCurrentIndex(int index) {
    currentIndex = index;
    _currentPage = 0;
    notifyListeners();
  }

  Future<void> closeAndGetStreams() async {
    transactionSubscription.cancel();
    getAllTransactionsStream(userId: userId);
    await fetchData(pageIndex: currentIndex);
    notifyListeners();
  }

  getAllTransactionsStream({required String userId}) {
    transactionSubscription =
        _transactionService.transactionsStream(userId: userId).listen(
      (onTransactionsReceived) {
        loadingData = 0;
        updateData(onTransactionsReceived);
        loadingData = 1;

        notifyListeners();
      },
      onError: (error) {
        loadingData = -1;
        customExceptionHandler.handleException(context, error);
        notifyListeners();
      },
    );
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
    transactionSubscription.cancel();
    transactions = [];
    totalProfit = 0.0;
    totalExpenses = 0.0;
    totalIncomes = 0.0;
    super.dispose();
  }
}
