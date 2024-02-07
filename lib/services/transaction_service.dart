import 'package:accountant_app/constants.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> getAllTransactions() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData = await client
        .from('transactions')
        .select('*')
        // .eq("id", userId)
        .execute();

    // print("responseData.data : ${responseData.data}");
    // print(
    //     "responseData.data.type : ${responseData.data.runtimeType.toString()}");
    return transactionsFromJson(responseData.data);
    // return responseData.data;
  }

  Future<List<TransactionModel>> getExpenses() async {
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq('isExpense', true)
        .execute();
    // print("responseData : $responseData");
    return transactionsFromJson(responseData.data);
  }

  Future<List<TransactionModel>> getIncomes() async {
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq('isExpense', false)
        .execute();
    // print("responseData : $responseData");
    return transactionsFromJson(responseData.data);
  }

  Future<List<TransactionModel>> getTransactionsInDateRange(
      {required DateTime startDate, required DateTime endDate}) async {
    final responseData = await client
        .from('transactions')
        .select('*')
        .gte('date', startDate.toIso8601String())
        .lte('date', endDate.toIso8601String())
        .execute();
    // print("responseData : $responseData");
    return transactionsFromJson(responseData.data);
  }

  // Similar implementations for getExpensesInDateRange and getIncomesInDateRange

  // Future<double> calculateProfitInDateRange(
  //     DateTime startDate, DateTime endDate) async {
  //   // Fetch transactions in the date range
  //   final transactions = await getTransactionsInDateRange(startDate, endDate);

  //   // Calculate profit by summing incomes and subtracting expenses
  //   final double profit = transactions
  //       .where((transaction) => !transaction.isExpense)
  //       .map((transaction) => transaction.amount)
  //       .fold(0, (acc, amount) => acc + amount) -
  //       transactions
  //           .where((transaction) => transaction.isExpense)
  //           .map((transaction) => transaction.amount)
  //           .fold(0, (acc, amount) => acc + amount);

  //   return profit;
  // }

  Future<bool> addTransaction({required TransactionModel transaction}) async {
    final responseData = await client
        .from('transactions')
        .upsert([transaction.toMap()]).execute();

    print("responseData $responseData");

    return true;
  }

  Future<void> deleteTransaction({required String id}) async {
    final responseData =
        await client.from('transactions').delete().eq('id', id).execute();
  }
}







// class TransactionService {
//   List<TransactionModel> transactions = [];

//   Future<List<TransactionModel>> getALLTransactions() async {
//     transactions = await client.from('transactions').select('*');
//     return transactions;
//   }

//   List<TransactionModel> get expenses =>
//       transactions.where((transaction) => transaction.isExpense).toList();

//   List<TransactionModel> get incomes =>
//       transactions.where((transaction) => !transaction.isExpense).toList();

//   List<TransactionModel> getTransactionsInDateRange(
//           DateTime startDate, DateTime endDate) =>
//       transactions
//           .where((transaction) =>
//               transaction.date.isAfter(startDate) &&
//               transaction.date.isBefore(endDate))
//           .toList();

//   List<TransactionModel> getExpensesInDateRange(
//           DateTime startDate, DateTime endDate) =>
//       expenses
//           .where((transaction) =>
//               transaction.date.isAfter(startDate) &&
//               transaction.date.isBefore(endDate))
//           .toList();

//   List<TransactionModel> getIncomesInDateRange(
//           DateTime startDate, DateTime endDate) =>
//       incomes
//           .where((transaction) =>
//               transaction.date.isAfter(startDate) &&
//               transaction.date.isBefore(endDate))
//           .toList();

//   double calculateProfitInDateRange(DateTime startDate, DateTime endDate) {
//     final List<TransactionModel> filteredTransactions =
//         getTransactionsInDateRange(startDate, endDate);

//     double totalIncome = 0.0;
//     double totalExpense = 0.0;

//     for (var transaction in filteredTransactions) {
//       if (transaction.isExpense) {
//         totalExpense += transaction.amount;
//       } else {
//         totalIncome += transaction.amount;
//       }
//     }

//     return totalIncome - totalExpense;
//   }

//   Future<void> addTransaction(TransactionModel transaction) async {
//     // transactions.add(transaction);
//     await client.from('transactions').insert([
//       transaction.toMap(),
//     ]).select();
//   }
// }



