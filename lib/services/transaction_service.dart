import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Stream<List<TransactionModel>> getAllTransactionStream() {
    String? userId = client.auth.currentSession?.user.id;
    return client
        .from('transactions')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map((maps) => transactionsFromListMap(maps));
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData =
        await client.from('transactions').select('*').eq("user_id", userId);
    return transactionsFromListMap(responseData);
  }

  Future<List<TransactionModel>> getExpenses() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq("user_id", userId)
        .eq('isExpense', true);
    return transactionsFromListMap(responseData);
  }

  Future<List<TransactionModel>> getIncomes() async {
    String? userId = client.auth.currentSession?.user.id;
    final responseData = await client
        .from('transactions')
        .select('*')
        .eq("user_id", userId)
        .eq('isExpense', false);
    return transactionsFromListMap(responseData);
  }

  Future<bool> addTransaction({required TransactionModel transaction}) async {
    await client.from('transactions').insert([transaction.toMap()]);
    return true;
  }
}
