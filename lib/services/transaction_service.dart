import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

class TransactionService {
  Stream<List<TransactionModel>> transactionsStream() {
    String? userId = client.auth.currentSession?.user.id;
    return client
        .from('transactions')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map((maps) => transactionsFromListMap(maps));
  }

  Future<bool> addTransaction({required TransactionModel transaction}) async {
    await client.from('transactions').insert([transaction.toMap()]);
    return true;
  }
}
