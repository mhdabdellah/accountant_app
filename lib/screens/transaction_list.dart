import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    Text(AppLocalizations.of(context)!.totalExpense),
                    Text(
                        "${transactionProvider.totalExpenses.toString()} ${AppLocalizations.of(context)!.mru}"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.totalIncome),
                    Text(
                        "${transactionProvider.totalIncomes.toString()} ${AppLocalizations.of(context)!.mru}"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.totalProfit),
                    Text(
                        "${transactionProvider.totalProfit.toString()} ${AppLocalizations.of(context)!.mru}"),
                  ],
                ),
              ],
            ),
          ),
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
