import 'package:accountant_app/constants/app_themes/app_colors.dart';
import 'package:accountant_app/custom_widgets/transaction_card.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/providers/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Transactions>();
    return provider.errorMessage != null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      provider.cancelAndgetTransactionsStream();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 50,
                    )),
                const SizedBox(
                  height: 8.0,
                ),
                Text(provider.errorMessage ?? ""),
              ],
            ),
          )
        : provider.isLoading
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
                              "${provider.totalExpenses.toString()} ${ApplicationLocalization.translator!.mru}"),
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
                              "${provider.totalIncomes.toString()} ${ApplicationLocalization.translator!.mru}"),
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
                              "${provider.totalProfit.toString()} ${ApplicationLocalization.translator!.mru}"),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: provider.currentPage > 0
                                ? () => provider.loadPreviousPage()
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
                                provider.currentPage.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: ApplicationColors.primaryColor,
                            radius: 5,
                          ),
                          const CircleAvatar(
                            backgroundColor: ApplicationColors.primaryColor,
                            radius: 5,
                          ),
                          const CircleAvatar(
                            backgroundColor: ApplicationColors.primaryColor,
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
                                provider.numberOfPages.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: provider.hasMore
                                ? () => provider.loadNextPage()
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
                    itemCount: provider.paginatedTransactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(
                          transaction: provider.paginatedTransactions[index]);
                    },
                  ),
                ),
              ]);
  }
}
