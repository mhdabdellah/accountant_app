import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';

class DisplayTransactions extends StatelessWidget {
  const DisplayTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthTransactionProvider>(
      builder: (context, authTransactionProvider, child) {
        // Your widget code here
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Display Transactions Page'),
              authTransactionProvider.isloaded
                  ? Expanded(
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
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
