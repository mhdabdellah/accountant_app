import 'package:accountant_app/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionHistoryCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionHistoryCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            border: Border.all(color: Colors.blue)),
        child: ExpansionTile(
          title: const Text(""),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${transaction.amount.toString()} MRU"),
              // Text(),
              Text(transaction.isExpense ? "Expense" : "Income"),
            ],
          ),
          children: [
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Title',
                    ),
                    Text(
                      transaction.title,
                    )
                  ]),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Amount'),
                  Text("${transaction.amount.toString()} MRU"),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Type'),
                  Text(transaction.isExpense ? "Expense" : "Income"),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date'),
                  Text(transaction.date.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
