import 'package:accountant_app/providers/base_transactions_provider.dart';
import 'package:accountant_app/services/base_transactions_services.dart';
import 'package:accountant_app/services/incomes_service.dart';

class Incomes extends BaseTransactionsProvider {
  @override
  BaseTransactionsServices get transactionService => IncomeServices();
}
