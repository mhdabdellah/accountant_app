import 'dart:async';

import 'package:accountant_app/constants/app_constants/utils.dart';
import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTransactionProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  final customExceptionHandler = CustomExceptionHandler();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedType = 'Expense';

  bool isloaded = true;

  AddTransactionProvider();

  setTypeValue(String value) {
    selectedType = value;
    notifyListeners();
  }

  Future<void> addTransaction() async {
    try {
      DateTime date = DateTime.now();
      String? userId = client.auth.currentSession?.user.id;

      final double amount = double.parse(amountController.text);
      final bool isExpense = selectedType == 'Expense';
      final String title = titleController.text;
      final transaction = TransactionModel(
        title: title,
        amount: amount,
        isExpense: isExpense,
        date: date,
        userId: userId ?? "",
      );

      await _transactionService.addTransaction(transaction: transaction);
      titleController.text = "";
      amountController.text = "";
      if (navigatorKey.currentState!.context.mounted) {
        SnackBarHelper.showSuccessSnackBar(
            navigatorKey.currentState!.context,
            AppLocalizations.of(navigatorKey.currentState!.context)!
                .theTransactionHasBeenRegisteredSuccessfully);
      }
      notifyListeners();
    } catch (error) {
      customExceptionHandler.handleException(
          navigatorKey.currentState!.context, error);
      SnackBarHelper.showErrorSnackBar(
          navigatorKey.currentState!.context,
          customExceptionHandler.handleException(
              navigatorKey.currentState!.context, error));
    }
  }

  @override
  void dispose() {
    titleController.text = "";
    amountController.text = "";
    selectedType = "";
    super.dispose();
  }
}
