import 'package:flutter/material.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';

import '../models/transaction_model.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({Key? key, required this.authTransactionProvider})
      : super(key: key);

  final AuthTransactionProvider authTransactionProvider;

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            onPressed: () {
              final double amount = double.parse(amountController.text);
              final bool isExpense = selectedType == 'Expense';

              final transaction = TransactionModel(
                id: UniqueKey().toString(),
                title: titleController.text,
                amount: amount,
                isExpense: isExpense,
                date: selectedDate,
              );

              widget.authTransactionProvider.addTransaction(transaction);
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
    );
  }
}
