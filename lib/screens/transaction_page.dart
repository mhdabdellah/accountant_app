import 'package:accountant_app/constants/routes_constants.dart';
import 'package:accountant_app/providers/auth_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_transaction_form.dart';

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
        title: const Text('Transactions'),
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

          // setState(() {

          // });

          // transactionProvider.getAllTransactions();
          // if (_currentIndex == 1) {
          //   await transactionProvider.getAllTransactions();
          // } else if (_currentIndex == 2) {
          //   await transactionProvider.getExpenses();
          // } else if (_currentIndex == 3) {
          //   await transactionProvider.getIncomes();
          // }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.black),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off, color: Colors.black),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money, color: Colors.black),
            label: 'Incomes',
          )
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
      default:
        return Container();
    }
  }
}
