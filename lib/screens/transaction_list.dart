import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  final int pageIndex;
  const TransactionList({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Expense"),
                    Text("${transactionProvider.totalExpenses.toString()} MRU"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Income"),
                    Text("${transactionProvider.totalIncomes.toString()} MRU"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Profit"),
                    Text("${transactionProvider.totalProfit.toString()} MRU"),
                  ],
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: pageIndex == 1
          //       ? StreamBuilder(
          //           stream: transactionProvider.transactionStreems,
          //           builder: (context, snapshot) {
          //             if (snapshot.connectionState == ConnectionState.waiting) {
          //               return const Center(child: CircularProgressIndicator());
          //             } else if (snapshot.hasError) {
          //               return Center(
          //                   child: Text(
          //                       'Erreur de chargement : ${snapshot.error.toString()}'));
          //             } else {
          //               List<TransactionModel> transactions =
          //                   transactionsFromListMap(snapshot.data);
          //               // transactions.sort((a, b) => b.date.compareTo(a.date));
          //               return ListView.builder(
          //                 itemCount: transactions.length,
          //                 itemBuilder: (context, index) {
          //                   return TransactionCard(
          //                       transaction: transactions[index]);
          //                 },
          //               );
          //             }
          //           },
          //         )
          //       : ListView.builder(
          //           itemCount: pageIndex == 2
          //               ? transactionProvider.expenses.length
          //               : transactionProvider.incomes.length,
          //           itemBuilder: (context, index) {
          //             return TransactionCard(
          //                 transaction: pageIndex == 2
          //                     ? transactionProvider.expenses[index]
          //                     : transactionProvider.incomes[index]);
          //           },
          //         ),
          // )
          Expanded(
            child: transactionProvider.isloaded
                ? ListView.builder(
                    itemCount: pageIndex == 2
                        ? transactionProvider.expenses.length
                        : pageIndex == 3
                            ? transactionProvider.incomes.length
                            : transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(
                          transaction: pageIndex == 2
                              ? transactionProvider.expenses[index]
                              : pageIndex == 3
                                  ? transactionProvider.incomes[index]
                                  : transactionProvider.transactions[index]);
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ]);
      },
    );
  }
}
