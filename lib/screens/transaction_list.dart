import 'package:accountant_app/constants/app_themes/app_colors.dart';
import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  final int pageIndex;
  const TransactionList({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    return transactionProvider.errorMessage != null
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
                Text(transactionProvider.errorMessage ?? ""),
              ],
            ),
          )
        : transactionProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              ApplicationLocalization.translator!.totalExpense),
                          Text(
                              "${transactionProvider.totalExpenses.toString()} ${ApplicationLocalization.translator!.mru}"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ApplicationLocalization.translator!.totalIncome),
                          Text(
                              "${transactionProvider.totalIncomes.toString()} ${ApplicationLocalization.translator!.mru}"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(ApplicationLocalization.translator!.totalProfit),
                          Text(
                              "${transactionProvider.totalProfit.toString()} ${ApplicationLocalization.translator!.mru}"),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: transactionProvider.currentPage > 0
                                ? () => transactionProvider.loadPreviousPage(
                                    pageIndex: transactionProvider.currentIndex)
                                : null,
                            child: const Icon(Icons.arrow_back),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: const Size(44.0, 44.0),
                              ),
                              child: Text(
                                transactionProvider.currentPage.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: ApplicationColors().primaryColor,
                            radius: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: ApplicationColors().primaryColor,
                            radius: 5,
                          ),
                          CircleAvatar(
                            backgroundColor: ApplicationColors().primaryColor,
                            radius: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: const Size(44.0, 44.0),
                              ),
                              child: Text(
                                transactionProvider.numberOfPages.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: transactionProvider.hasMore
                                ? () => transactionProvider.loadNextPage(
                                    pageIndex: transactionProvider.currentIndex)
                                : null,
                            child: const Icon(Icons.arrow_forward),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: transactionProvider.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(
                          transaction: transactionProvider.transactions[index]);
                    },
                  ),
                ),
              ]);
  }
}
