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
        return transactionProvider.loadingData == -1
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          transactionProvider.closeAndGetStreams();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          size: 50,
                        )),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(AppLocalizations.of(context)!.unexpectedErrorOccurred),
                  ],
                ),
              )

            // Center(
            //     child: IconButton(
            //       icon: const Icon(
            //         Icons.autorenew_sharp,
            //         size: 50,
            //         color: primaryColor,
            //       ),
            //       onPressed: () {
            //         transactionProvider.closeAndGetStreams();
            //       },
            //     ),
            //   )
            : transactionProvider.loadingData == 0
                ? const Center(child: CircularProgressIndicator())
                : Column(children: [
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: transactionProvider.currentPage > 0
                                    ? () =>
                                        transactionProvider.loadPreviousPage(
                                            pageIndex: transactionProvider
                                                .currentIndex)
                                    : null,
                                child: const Icon(Icons.arrow_back),
                              ),
                              ElevatedButton(
                                onPressed: transactionProvider.hasMore
                                    ? () => transactionProvider.loadNextPage(
                                        pageIndex:
                                            transactionProvider.currentIndex)
                                    : null,
                                child: const Icon(Icons.arrow_forward),
                              ),
                            ],
                          )

                          // const PaginationControls(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactionProvider.transactions.length,
                        itemBuilder: (context, index) {
                          return TransactionCard(
                              transaction:
                                  transactionProvider.transactions[index]);
                        },
                      ),
                    ),
                  ]);

        // transactionProvider.loadingData == 0
        //     ? const Center(child: CircularProgressIndicator())
        //     : transactionProvider.loadingData == -1
        //         // ? Center(
        //         //     child: IconButton(
        //         //       icon: const Icon(
        //         //         Icons.autorenew_sharp,
        //         //         size: 50,
        //         //         color: primaryColor,
        //         //       ),
        //         //       onPressed: () {
        //         //         transactionProvider.closeAndGetStreams();
        //         //       },
        //         //     ),
        //         //   )
        //         ? Expanded(
        //             child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               IconButton(
        //                   onPressed: () {
        //                     transactionProvider.closeAndGetStreams();
        //                   },
        //                   icon: const Icon(
        //                     Icons.refresh,
        //                     size: 70,
        //                   )),
        //               const SizedBox(
        //                 height: 8.0,
        //               ),
        //               Text(AppLocalizations.of(context)!
        //                   .unexpectedErrorOccurred),
        //             ],
        //           ))
        //         : Column(children: [
        //             Padding(
        //               padding: const EdgeInsets.all(20.0),
        //               child: Column(
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(AppLocalizations.of(context)!.totalExpense),
        //                       Text(
        //                           "${transactionProvider.totalExpenses.toString()} ${AppLocalizations.of(context)!.mru}"),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 20,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(AppLocalizations.of(context)!.totalIncome),
        //                       Text(
        //                           "${transactionProvider.totalIncomes.toString()} ${AppLocalizations.of(context)!.mru}"),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 20,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(AppLocalizations.of(context)!.totalProfit),
        //                       Text(
        //                           "${transactionProvider.totalProfit.toString()} ${AppLocalizations.of(context)!.mru}"),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Column(
        //               children: [
        //                 const PaginationControls(),
        //                 Expanded(
        //                   child: ListView.builder(
        //                     itemCount: transactionProvider.transactions.length,
        //                     // pageIndex == 2
        //                     //     ? transactionProvider.expenses.length
        //                     //     : pageIndex == 3
        //                     //         ? transactionProvider.incomes.length
        //                     //         : transactionProvider.transactions.length,
        //                     itemBuilder: (context, index) {
        //                       return TransactionCard(
        //                           transaction:
        //                               transactionProvider.transactions[index]);
        //                       // transaction: pageIndex == 2
        //                       //     ? transactionProvider.expenses[index]
        //                       //     : pageIndex == 3
        //                       //         ? transactionProvider.incomes[index]
        //                       //         : transactionProvider
        //                       //             .transactions[index]);
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ]);
      },
    );
  }
}
