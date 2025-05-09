import 'package:accountant_app/providers/base_transactions_provider.dart';
import 'package:accountant_app/services/all_transactions_service.dart';
import 'package:accountant_app/services/base_transactions_services.dart';

class Transactions extends BaseTransactionsProvider {
  @override
  BaseTransactionsServices get transactionService => AllTransactionsServices();
}
