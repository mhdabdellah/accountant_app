import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/base_transactions_services.dart';

class IncomeServices extends BaseTransactionsServices {
  // @override
  // get getNumberOfTransactionsquery => SupabaseConfig()
  //     .client
  //     .from('transactions')
  //     .select('count')
  //     .eq('user_id', BaseTransactionsServices.userId)
  //     .eq('isExpense', false)
  //     .single();

  @override
  Future<List<TransactionModel>> getTransactions(
      {required int start, required int end}) async {
    return BaseTransactionsServices.transactionsFromListMap(
        await SupabaseConfig()
            .client
            .from('transactions')
            .select("*")
            .eq('user_id', BaseTransactionsServices.userId)
            .eq('isExpense', false)
            .order('created_at')
            .range(start, end));
  }

  @override
  Future<List<TransactionModel>> fetchTransactions() async {
    return BaseTransactionsServices.transactionsFromListMap(
        await SupabaseConfig()
            .client
            .from('transactions')
            .select("*")
            .eq('user_id', BaseTransactionsServices.userId)
            .eq('isExpense', false)
            .order('created_at'));
  }
}
