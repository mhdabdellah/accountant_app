import 'dart:async';

import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/helpers/snack_bar_helper.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/models/transactions_type.dart';
import 'package:accountant_app/services/all_transactions_service.dart';
import 'package:flutter/material.dart';

class AddTransactionProvider extends ChangeNotifier {
  final AllTransactionsServices _transactionService = AllTransactionsServices();

  final customExceptionHandler = ExceptionHandler();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedType = TransactionsType.expense.name;

  bool isloaded = true;

  AddTransactionProvider();

  setTypeValue(String value) {
    selectedType = value;
    notifyListeners();
  }

  Future<void> _add() async {
    DateTime date = DateTime.now();
    String? userId = SupabaseConfig().currentUserId;

    final double amount = double.parse(amountController.text);
    final bool isExpense = selectedType == TransactionsType.expense.name;
    final String title = titleController.text;
    final transaction = TransactionModel(
      title: title,
      amount: amount,
      isExpense: isExpense,
      date: date,
      userId: userId,
    );

    await _transactionService.addTransaction(transaction: transaction);
    titleController.clear();
    amountController.clear();
    notifyListeners();
  }

  Future<void> addTransaction() async {
    final response = await customExceptionHandler.exceptionCatcher<void>(
        function: () => _add());

    if (response.isError) return;

    SnackBarHelper.showSuccessSnackBar(ApplicationLocalization
        .translator.theTransactionHasBeenRegisteredSuccessfully);
  }
}
