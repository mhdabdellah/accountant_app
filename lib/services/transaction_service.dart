import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Stream<List<TransactionModel>> transactionsStream({required String userId}) {
    if (userId == "") {
      return const Stream.empty();
    }
    return client
        .from('transactions')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map((maps) => transactionsFromListMap(maps));
  }

  Future<List<TransactionModel>> fetchTransactions(
      {required int pageSize,
      required int start,
      required int end,
      required String userId,
      required int pageIndex}) async {
    if (pageIndex == 1) {
      return transactionsFromListMap(await client
          .from('transactions')
          .select("*")
          .eq('user_id', userId)
          .limit(pageSize)
          .order('created_at')
          .range(start, end));
    } else if (pageIndex == 2) {
      return transactionsFromListMap(await client
          .from('transactions')
          .select("*")
          .eq('user_id', userId)
          .eq('isExpense', pageIndex == 2)
          .limit(pageSize)
          .order('created_at')
          .range(start, end));
    } else if (pageIndex == 3) {
      return transactionsFromListMap(await client
          .from('transactions')
          .select("*")
          .eq('user_id', userId)
          .eq('isExpense', false)
          .limit(pageSize)
          .order('created_at')
          .range(start, end));
    } else {
      List<TransactionModel> emptyTransactionsList = [];
      return emptyTransactionsList;
    }
  }

  Future<void> addTransaction({required TransactionModel transaction}) async {
    await client.from('transactions').insert([transaction.toMap()]);
  }
}
