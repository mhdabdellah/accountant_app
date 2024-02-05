import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedType = 'Expense'; // Default value
  DateTime selectedDate = DateTime.now(); // Default value

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
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

                authTransactionProvider.addTransaction(transaction);
              },
              child: const Text('Add Transaction'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authTransactionProvider.getExpenses();
              },
              child: const Text('Show Expenses'),
            ),
            ElevatedButton(
              onPressed: () async {
                await authTransactionProvider.getIncomes();
              },
              child: const Text('Show Incomes'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await authTransactionProvider.getExpensesInDateRange(
            //         startDate, endDate);
            //   },
            //   child: const Text('Show Expenses in Date Range'),
            // ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await authTransactionProvider.getIncomesInDateRange(
            //         startDate, endDate);
            //     // Utilisez filteredIncomesInDateRange comme vous le souhaitez
            //   },
            //   child: const Text('Show Incomes in Date Range'),
            // ),
            ElevatedButton(
              onPressed: () async {
                await authTransactionProvider.getTransactionsInDateRange(
                    startDate, endDate);
                // Utilisez filteredTransactionsInDateRange comme vous le souhaitez
              },
              child: const Text('Show All Transactions in Date Range'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     final double profitInDateRange = authTransactionProvider
            //         .calculateProfitInDateRange(startDate, endDate);
            //     // Utilisez profitInDateRange comme vous le souhaitez
            //   },
            //   child: const Text('Calculate Profit in Date Range'),
            // ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: authTransactionProvider.transactions.length,
                itemBuilder: (context, index) {
                  final transaction =
                      authTransactionProvider.transactions[index];
                  return ListTile(
                    title: Text(transaction.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ${transaction.amount}'),
                        Text(
                            'Type: ${transaction.isExpense ? 'Expense' : 'Income'}'),
                        Text('Date: ${transaction.date.toLocal()}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
