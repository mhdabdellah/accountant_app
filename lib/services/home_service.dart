import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:accountant_app/services/base_transactions_services.dart';

class HomeService {
  Future<Map<String, double>> tranactionsAmounts() async {
    double totalProfit = 0.0;
    double totalExpenses = 0.0;
    double totalIncomes = 0.0;

    List<TransactionModel> transactions =
        BaseTransactionsServices.transactionsFromListMap(await SupabaseConfig()
            .client
            .from('transactions')
            .select("*")
            .eq('user_id', BaseTransactionsServices.userId)
            .order('created_at'));

    for (TransactionModel transaction in transactions) {
      if (transaction.isExpense) {
        totalExpenses += transaction.amount;
      } else {
        totalIncomes += transaction.amount;
      }
    }

    totalProfit = totalIncomes - totalExpenses;
    Map<String, double> amouts = {
      'totalProfit': totalProfit,
      'totalExpenses': totalExpenses,
      'totalIncomes': totalIncomes,
    };
    return amouts;
  }
}
