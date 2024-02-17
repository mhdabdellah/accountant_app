import 'package:accountant_app/providers/add_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTransactionForm extends StatelessWidget {
  const AddTransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addTransactionProvider = Provider.of<AddTransactionProvider>(context);
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
              controller: addTransactionProvider.titleController,
              decoration: InputDecoration(
                icon: const Icon(Icons.description, color: Colors.black),
                labelText: AppLocalizations.of(context)!.title,
              ),
            ),
            TextFormField(
              controller: addTransactionProvider.amountController,
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
                  groupValue: addTransactionProvider.selectedType,
                  onChanged: (String? value) {
                    if (value != null) {
                      addTransactionProvider.setTypeValue(value);
                    }
                  },
                ),
                Text(AppLocalizations.of(context)!.expense),
                Radio<String>(
                  value: 'Income',
                  groupValue: addTransactionProvider.selectedType,
                  onChanged: (String? value) {
                    if (value != null) {
                      addTransactionProvider.setTypeValue(value);
                    }
                  },
                ),
                Text(AppLocalizations.of(context)!.income),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addTransactionProvider.addTransaction();
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
