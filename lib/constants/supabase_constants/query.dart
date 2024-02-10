import 'config.dart';

final transactionsQuery =
    client.from('transactions').select('*').eq("user_id", userId);
final expensesQuery = client
    .from('transactions')
    .select('*')
    .eq("user_id", userId)
    .eq('isExpense', true);
final incomesQuery = client
    .from('transactions')
    .select('*')
    .eq("user_id", userId)
    .eq('isExpense', false);

Stream transactionsStreamQuery = client
    .from('transactions')
    .stream(primaryKey: ["id"]).eq("user_id", userId);

Stream expensesStreamQuery =
    client.from('transactions').stream(primaryKey: ["id"])
        // .eq("user_id", userId)
        .eq('isExpense', true);

Stream incomesStreamQuery =
    client.from('transactions').stream(primaryKey: ["id"])
        // .eq("user_id", userId)
        .eq('isExpense', false);
