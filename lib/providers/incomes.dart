import 'dart:math';

import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/providers/main_provider.dart';

class Incomes extends MainProvider {
  Incomes() {
    init();
  }
  Future<void> fetch() async {
    isLoading = true;
    errorMessage = null;
    final pages = await transactionService.getNumberOfIncomes(
        pageSize: pageSize, userId: currentUserProvider.currentUserId);
    numberOfPages = pages;

    final start = currentPage * pageSize;
    final end = start + pageSize;
    // transactions = await transactionService.fetchIncoms(
    //   start: start,
    //   end: end,
    //   userId: currentUserProvider.currentUserId,
    // );
    paginatedIncomes = paginateTransactions(start, end);

    hasMore = currentPage < pages;
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
  // Function to perform pagination
  List<TransactionModel> paginateTransactions(int start, int end) {
    if (start < 0) {
      throw ArgumentError('Invalid start and end values.');
    }

    // Ensure end does not exceed the length of the list
    end = min(end, allIncomes.length);

    return allIncomes.sublist(start, end);
  }
}
