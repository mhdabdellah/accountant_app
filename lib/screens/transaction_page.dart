import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accountant_app/providers/auth_transaction_provider.dart';

import 'add_transaction_form.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedType = 'Expense';
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: _buildBody(authTransactionProvider),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            authTransactionProvider.getAllTransactions();
          } else if (index == 2) {
            authTransactionProvider.getExpenses();
          } else if (index == 3) {
            authTransactionProvider.getIncomes();
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: const TextStyle(color: Colors.black),
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
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.date_range, color: Colors.black),
          //   label: 'Date Range',
          // ),
        ],
      ),
    );
  }

  Widget _buildBody(AuthTransactionProvider authTransactionProvider) {
    switch (_currentIndex) {
      case 0:
        return AddTransactionForm(
            authTransactionProvider: authTransactionProvider);
      case 1:
        authTransactionProvider.getAllTransactions();
        return const TransactionList();
      case 2:
        authTransactionProvider.getExpenses();
        return const TransactionList();

      case 3:
        authTransactionProvider.getIncomes();
        return const TransactionList();
      // case 4:
      //   return
      default:
        return Container();
    }
  }
}
