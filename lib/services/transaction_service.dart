import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Future<List<TransactionModel>> tranactionsAmounts({
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client!
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .order('created_at'));
  }

  Future<int> getNumberOfTransactions(
      {required String userId,
      required int pageSize,
      required int pageIndex}) async {
    int pages = 0;

    if (pageIndex == 1) {
      final countResponse = await SupabaseConfig()
          .client!
          .from('transactions')
          .select('count')
          .eq('user_id', userId)
          .single();
      if (countResponse['count'] == 0) {
        pages = countResponse['count'];
      } else {
        if (countResponse['count'] % pageSize == 0) {
          pages = (countResponse['count'] / pageSize).toInt() - 1;
        } else {
          pages = (countResponse['count'] / pageSize).toInt();
        }
      }
    } else if (pageIndex == 2) {
      final countResponse = await SupabaseConfig()
          .client!
          .from('transactions')
          .select('count')
          .eq('user_id', userId)
          .eq('isExpense', true)
          .single();

      if (countResponse['count'] == 0) {
        pages = countResponse['count'];
      } else {
        if (countResponse['count'] % pageSize == 0) {
          pages = (countResponse['count'] / pageSize).toInt() - 1;
        } else {
          pages = (countResponse['count'] / pageSize).toInt();
        }
      }
    } else {
      final countResponse = await SupabaseConfig()
          .client!
          .from('transactions')
          .select('count')
          .eq('user_id', userId)
          .eq('isExpense', false)
          .single();
      if (countResponse['count'] == 0) {
        pages = countResponse['count'];
      } else {
        if (countResponse['count'] % pageSize == 0) {
          pages = (countResponse['count'] / pageSize).toInt() - 1;
        } else {
          pages = (countResponse['count'] / pageSize).toInt();
        }
      }
    }

    return pages;
  }

  Future<List<TransactionModel>> fetchAllTransactions({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client!
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        // .limit(pageSize)
        .order('created_at')
        .range(start, end));
  }

  Future<List<TransactionModel>> fetchExpenses({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client!
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .eq('isExpense', true)
        // .limit(pageSize)
        .order('created_at')
        .range(start, end));
  }

  Future<List<TransactionModel>> fetchIncoms({
    required int start,
    required int end,
    required String userId,
  }) async {
    return transactionsFromListMap(await SupabaseConfig()
        .client!
        .from('transactions')
        .select("*")
        .eq('user_id', userId)
        .eq('isExpense', false)
        // .limit(pageSize)
        .order('created_at')
        .range(start, end));
  }

  Future<void> addTransaction({required TransactionModel transaction}) async {
    await SupabaseConfig()
        .client!
        .from('transactions')
        .insert([transaction.toMap()]);
  }
}
