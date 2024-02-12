import 'package:accountant_app/constants/app_constants/routes_constants.dart';
import 'package:accountant_app/providers/auth_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/aboutDevelopper.dart';
import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_transaction_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Transactions'),
        title: transactionProvider.currentIndex == 4
            ? Text(AppLocalizations.of(context)!.aboutDeveloper)
            : Text(AppLocalizations.of(context)!.transactions),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              if (await authProvider.logOut() == true) {
                Navigator.pushReplacementNamed(context, login);
              }
            },
          )
        ],
      ),
      body: _buildBody(transactionProvider),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: transactionProvider.currentIndex,
        onTap: (index) {
          transactionProvider.updateCurrentIndex(index);
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
        return const AddTransactionForm();
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
        return const AboutDeveloper(); // Button/Link in AboutDeveloperPag
      default:
        return Container();
    }
  }
}
