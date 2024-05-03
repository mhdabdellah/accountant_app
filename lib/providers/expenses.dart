import 'package:accountant_app/providers/base_transactions_provider.dart';
import 'package:accountant_app/services/base_transactions_services.dart';
import 'package:accountant_app/services/expenses_service.dart';

class Expenses extends BaseTransactionsProvider {
  @override
  BaseTransactionsServices get transactionService => ExpensesService();
}
