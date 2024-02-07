import 'package:accountant_app/constants.dart';
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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              print(
                  "client.auth.currentSession : ${client.auth.currentSession}");
              var user =
                  client.auth.currentSession?.user.userMetadata?['firstName'];
              print("userId : $user");
              if (await authTransactionProvider.logOut() == true) {
                Navigator.pushReplacementNamed(context, "/login");
              }
            },
          )
        ],
      ),
      body: _buildBody(authTransactionProvider),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 1) {
            await authTransactionProvider.getAllTransactions();
          } else if (_currentIndex == 2) {
            await authTransactionProvider.getExpenses();
          } else if (_currentIndex == 3) {
            await authTransactionProvider.getIncomes();
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
          )
        ],
      ),
    );
  }

  Widget _buildBody(AuthTransactionProvider authTransactionProvider) {
    switch (_currentIndex) {
      case 0:
        return const AddTransactionForm();
      case 1:
        return const TransactionList();
      case 2:
        return const TransactionList();
      case 3:
        return const TransactionList();
      default:
        return Container();
    }
  }
}
