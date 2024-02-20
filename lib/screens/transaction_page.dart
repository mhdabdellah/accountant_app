import 'package:accountant_app/helpers/navigation.dart';
import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/providers/current_user_provider.dart';
import 'package:accountant_app/providers/transaction_provider.dart';
import 'package:accountant_app/screens/aboutDevelopper.dart';
import 'package:accountant_app/screens/add_transaction_form.dart';
import 'package:accountant_app/screens/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  static const String transactionsPageRoute = '/transactions';
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TransactionProvider(
            userId: AppNavigator.currentUserProvider.currentUserId),
        child: const _TransactionPage());
  }
}

class _TransactionPage extends StatelessWidget {
  const _TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();
    final currentUserProvider = context.watch<CurrentUserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: transactionProvider.currentIndex == 4
            ? Text(Utils.translator!.aboutDeveloper)
            : Text(Utils.translator!.transactions),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: currentUserProvider.logOut,
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
            label: Utils.translator!.add,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list, color: Colors.black),
            label: Utils.translator!.transactions,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.money_off, color: Colors.black),
            label: Utils.translator!.expenses,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.attach_money, color: Colors.black),
            label: Utils.translator!.incomes,
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.open_in_new),
              label: Utils.translator!.aboutDeveloper)
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
        return AboutDeveloper();
      default:
        return Container();
    }
  }
}
