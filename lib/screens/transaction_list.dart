import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
  }) : super(key: key);

  // final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);

    return
        // authTransactionProvider.isloaded
        //     ?
        Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // const ExpenseIncomeChart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Expense"),
                Text("${authTransactionProvider.totalExpenses.toString()} MRU"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Income"),
                Text("${authTransactionProvider.totalIncomes.toString()} MRU"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Profit"),
                Text("${authTransactionProvider.totalProfit.toString()} MRU"),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: authTransactionProvider.transactions.length,
          itemBuilder: (context, index) {
            // final transaction = authTransactionProvider.transactions[index];
            return TransactionHistoryCard(
              transaction: authTransactionProvider.transactions[index],
            );

            // ListTile(
            //   title: Text(transaction.title),
            //   subtitle: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Amount: ${transaction.amount}'),
            //       Text('Type: ${transaction.isExpense ? 'Expense' : 'Income'}'),
            //       Text('Date: ${transaction.date.toLocal()}'),
            //     ],
            //   ),
            // );
          },
        ),
      ),
    ]);
    // : const Center(child: CircularProgressIndicator());
  }
}
