import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedType = 'Expense';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset("assets/logo.json")),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                icon: Icon(Icons.description, color: Colors.black),
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money, color: Colors.black),
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Type:'),
                Radio<String>(
                  value: 'Expense',
                  groupValue: selectedType,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedType = value;
                      });
                    }
                  },
                ),
                const Text('Expense'),
                Radio<String>(
                  value: 'Income',
                  groupValue: selectedType,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedType = value;
                      });
                    }
                  },
                ),
                const Text('Income'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (amountController.text != "" && titleController.text != "") {
                  final double amount = double.parse(amountController.text);
                  final bool isExpense = selectedType == 'Expense';
                  final transaction = TransactionModel(
                    id: UniqueKey().toString(),
                    title: titleController.text,
                    amount: amount,
                    isExpense: isExpense,
                    date: selectedDate,
                  );

                  bool response =
                      await authTransactionProvider.addTransaction(transaction);
                  if (response) {
                    titleController.text = "";
                    amountController.text = "";
                    SnackBarHelper.showSuccessSnackBar(context,
                        "The transaction has been registered successfully.");
                  } else {
                    SnackBarHelper.showErrorSnackBar(
                        context, "Error!! The transaction was not registered.");
                  }
                } else {
                  SnackBarHelper.showErrorSnackBar(
                      context, "Error!! The transaction was not registered.");
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.add, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Add Transaction'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
