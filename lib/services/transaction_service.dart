import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  List<TransactionModel> transactionsFromListMap(List<dynamic> mapData) {
    List<TransactionModel> transactionModels =
        mapData.map((map) => TransactionModel.fromMap(map)).toList();
    return transactionModels;
  }

  Stream<List<TransactionModel>> transactionStream({required String userId}) {
    return SupabaseConfig()
        .client
        .from('transactions')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map((maps) => transactionsFromListMap(maps));
  }

  Future<List<TransactionModel>> tranactionsAmounts({
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .order('created_at'));
  }

  Future<int> getNumberOfAllTransactions(
      {required int pageSize, required String userId}) async {
    final countResponse = await SupabaseConfig()
        .client
        .from('transactions')
        .select('count')
        .eq('user_id', userId)
        .single();

    if (countResponse['count'] == 0) {
      return countResponse['count'];
    } else {
      if (countResponse['count'] % pageSize == 0) {
        print(
            "(countResponse['count'] / pageSize).toInt() - 1 ${(countResponse['count'] / pageSize).toInt() - 1}");
        return (countResponse['count'] / pageSize).toInt() - 1;
      } else {
        print(
            "(countResponse['count'] / pageSize).toInt() ${(countResponse['count'] / pageSize).toInt()}");
        return (countResponse['count'] / pageSize).toInt();
      }
    }
  }

  Future<int> getNumberOfExpenses(
      {required int pageSize, required String userId}) async {
    final countResponse = await SupabaseConfig()
        .client
        .from('transactions')
        .select('count')
        .eq('user_id', userId)
        .eq('isExpense', true)
        .single();

    if (countResponse['count'] == 0) {
      return countResponse['count'];
    } else {
      if (countResponse['count'] % pageSize == 0) {
        return (countResponse['count'] / pageSize).toInt() - 1;
      } else {
        return (countResponse['count'] / pageSize).toInt();
      }
    }
  }

  Future<int> getNumberOfIncomes(
      {required int pageSize, required String userId}) async {
    final countResponse = await SupabaseConfig()
        .client
        .from('transactions')
        .select('count')
        .eq('user_id', userId)
        .eq('isExpense', false)
        .single();

    if (countResponse['count'] == 0) {
      return countResponse['count'];
    } else {
      if (countResponse['count'] % pageSize == 0) {
        return (countResponse['count'] / pageSize).toInt() - 1;
      } else {
        return (countResponse['count'] / pageSize).toInt();
      }
    }
  }

  Future<List<TransactionModel>> fetchAllTransactions({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .order('created_at')
        .range(start, end));
  }

  Future<List<TransactionModel>> fetchExpenses({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .eq('isExpense', true)
        .order('created_at')
        .range(start, end));
  }

  Future<List<TransactionModel>> fetchIncoms({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .eq('isExpense', false)
        .order('created_at')
        .range(start, end));
  }

  Future<void> addTransaction({required TransactionModel transaction}) async {
    await SupabaseConfig()
        .client
        .from('transactions')
        .insert([transaction.toMap()]);
  }
}
