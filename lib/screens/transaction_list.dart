import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthTransactionProvider>(
      builder: (context, authTransactionProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Expense"),
                    Text(
                        "${authTransactionProvider.totalExpenses.toString()} MRU"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Income"),
                    Text(
                        "${authTransactionProvider.totalIncomes.toString()} MRU"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Profit"),
                    Text(
                        "${authTransactionProvider.totalProfit.toString()} MRU"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: authTransactionProvider.isloaded
                ? ListView.builder(
                    itemCount: authTransactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionHistoryCard(
                        transaction:
                            authTransactionProvider.transactions[index],
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ]);
      },
    );
  }
}
