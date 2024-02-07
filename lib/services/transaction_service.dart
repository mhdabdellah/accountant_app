import 'package:accountant_app/constants.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> getAllTransactions() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData =
        await client.from('transactions').select('*').eq("user_id", userId);
    return transactionsFromJson(responseData);
  }

  Future<List<TransactionModel>> getExpenses() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq("user_id", userId)
        .eq('isExpense', true);
    return transactionsFromJson(responseData);
  }

  Future<List<TransactionModel>> getIncomes() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq("user_id", userId)
        .eq('isExpense', false);
    return transactionsFromJson(responseData);
  }

  Future<bool> addTransaction({required TransactionModel transaction}) async {
    await client.from('transactions').insert([transaction.toMap()]);
    return true;
  }
}
