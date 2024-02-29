import 'dart:math';

import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/providers/main_provider.dart';

class Transactions extends MainProvider {
  Transactions() {
    init();
  }

  Future<void> fetch() async {
    isLoading = true;
    errorMessage = null;
    numberOfPages = await transactionService.getNumberOfAllTransactions(
        pageSize: pageSize, userId: currentUserProvider.currentUserId);
    // numberOfPages = pages;

    final start = currentPage * pageSize;
    final end = start + pageSize;
    // transactions = await transactionService.fetchAllTransactions(
    //   start: start,
    //   end: end,
    //   userId: currentUserProvider.currentUserId,
    // );

    paginatedTransactions = paginateTransactions(start, end);

    hasMore = currentPage < numberOfPages;
    isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> fetchData() async {
    final response = await exceptionHandler.exceptionCatcher<void>(
        function: () => fetch(), showSnackbar: false);

    if (response.isError) {
      errorMessage = response.error!;
      notifyListeners();
    }
  }

  @override
  List<TransactionModel> paginateTransactions(int start, int end) {
    if (start < 0) {
      throw ArgumentError('Invalid start and end values.');
    }

    // Ensure end does not exceed the length of the list
    end = min(end, allTransactions.length);

    return allTransactions.sublist(start, end);
  }
}
