import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';

abstract class BaseTransactionsServices {
  static String userId = SupabaseConfig().currentUserId;
  // dynamic get getNumberOfTransactionsquery;

  Future<List<TransactionModel>> fetchTransactions();

  Future<List<TransactionModel>> getTransactions({
    required int start,
    required int end,
  });
  static List<TransactionModel> transactionsFromListMap(List<dynamic> mapData) {
    List<TransactionModel> transactionModels =
        mapData.map((map) => TransactionModel.fromMap(map)).toList();
    return transactionModels;
  }

  // int getNumberOfpages(
  //     {required int pageSize, required List<TransactionModel> transactions}) {
  //   // final countResponse = await getNumberOfTransactionsquery;
  //   final numberOfTransactions = transactions.length;
  //   if (numberOfTransactions == 0) {
  //     return numberOfTransactions;
  //   } else {
  //     if (numberOfTransactions % pageSize == 0) {
  //       return numberOfTransactions ~/ pageSize - 1;
  //     } else {
  //       return numberOfTransactions ~/ pageSize;
  //     }
  //   }
  // }

  Future<void> addTransaction({required TransactionModel transaction}) async {
    await SupabaseConfig()
        .client
        .from('transactions')
        .insert([transaction.toMap()]);
  }
}
