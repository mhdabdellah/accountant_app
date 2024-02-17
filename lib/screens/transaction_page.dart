import 'package:accountant_app/providers/add_transaction_provider.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/aboutDevelopper.dart';
import 'package:accountant_app/screens/add_transaction_form.dart';
import 'package:accountant_app/screens/login_screen.dart';
import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionPage extends StatelessWidget {
  final String transactionsPageRoute = '/transactions';
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: transactionProvider.currentIndex == 4
            ? Text(AppLocalizations.of(context)!.aboutDeveloper)
            : Text(AppLocalizations.of(context)!.transactions),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await currentUserProvider.logOut(context);
            },
          )
        ],
      ),
      body: _buildBody(transactionProvider),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: transactionProvider.currentIndex,
        onTap: (index) async {
          await transactionProvider.updateCurrentIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.add, color: Colors.black),
            label: AppLocalizations.of(context)!.add,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list, color: Colors.black),
            label: AppLocalizations.of(context)!.transactions,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.money_off, color: Colors.black),
            label: AppLocalizations.of(context)!.expenses,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money, color: Colors.black),
            label: AppLocalizations.of(context)!.incomes,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.open_in_new),
              label: AppLocalizations.of(context)!.aboutDeveloper)
        ],
      ),
    );
  }

  Widget _buildBody(TransactionProvider transactionProvider) {
    switch (transactionProvider.currentIndex) {
      case 0:
        return ChangeNotifierProvider(
            create: (_) => AddTransactionProvider(),
            child: const AddTransactionForm());
      case 1:
        return const TransactionList(
          pageIndex: 1,
        );
      case 2:
        return const TransactionList(
          pageIndex: 2,
        );
      case 3:
        return const TransactionList(
          pageIndex: 3,
        );
      case 4:
        return AboutDeveloper();
      default:
        return Container();
    }
  }
}
