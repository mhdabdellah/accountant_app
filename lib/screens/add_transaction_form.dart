import 'package:accountant_app/custom_widgets/snack_bar_helper.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
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
              decoration: InputDecoration(
                icon: const Icon(Icons.description, color: Colors.black),
                labelText: AppLocalizations.of(context)!.title,
              ),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: const Icon(Icons.attach_money, color: Colors.black),
                labelText: AppLocalizations.of(context)!.amount,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.type),
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
                Text(AppLocalizations.of(context)!.expense),
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
                Text(AppLocalizations.of(context)!.income),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (amountController.text != "" && titleController.text != "") {
                  final double amount = double.parse(amountController.text);
                  final bool isExpense = selectedType == 'Expense';
                  final String title = titleController.text;

                  bool response = await transactionProvider.addTransaction(
                      title: title, amount: amount, isExpense: isExpense);
                  if (response) {
                    titleController.text = "";
                    amountController.text = "";
                    SnackBarHelper.showSuccessSnackBar(
                        context,
                        AppLocalizations.of(context)!
                            .theTransactionHasBeenRegisteredSuccessfully);
                  } else {
                    SnackBarHelper.showErrorSnackBar(
                        context,
                        AppLocalizations.of(context)!
                            .errorTheTransactionWasNotRegistered);
                  }
                } else {
                  SnackBarHelper.showErrorSnackBar(
                      context,
                      AppLocalizations.of(context)!
                          .errorTheTransactionWasNotRegistered);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, color: Colors.black),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.addTransaction),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
