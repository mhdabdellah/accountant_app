import 'package:accountant_app/providers/auth_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class ExpenseIncomeChart extends StatelessWidget {
  // final List<TransactionModel> transactions;

  const ExpenseIncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Categorize transactions into expenses and incomes
    final authTransactionProvider =
        Provider.of<AuthTransactionProvider>(context);
    double totalExpenses = 0;
    double totalIncomes = 0;

    for (var transaction in authTransactionProvider.transactions) {
      if (transaction.isExpense) {
        totalExpenses += transaction.amount;
      } else {
        totalIncomes += transaction.amount;
      }
    }

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.red,
            value: totalExpenses,
            title:
                '\$${totalExpenses.toStringAsFixed(2)}', // Display total expenses
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            color: Colors.green,
            value: totalIncomes,
            title:
                '\$${totalIncomes.toStringAsFixed(2)}', // Display total incomes
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
