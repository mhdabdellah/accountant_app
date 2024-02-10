List<TransactionModel> transactionsFromListMap(List<dynamic> mapData) {
  List<TransactionModel> transactionModels =
      mapData.map((map) => TransactionModel.fromMap(map)).toList();
  return transactionModels;
}

Stream<List<TransactionModel>> transactionsStreamFromSupabase(
    Stream supabaseStream) {
  return supabaseStream.map((response) =>
      response.data.map((map) => TransactionModel.fromMap(map)).toList());
}

class TransactionModel {
  final String? id;
  final String title;
  final double amount;
  final bool isExpense;
  final DateTime date;
  final String userId;

  TransactionModel(
      {this.id,
      required this.title,
      required this.amount,
      required this.isExpense,
      required this.date,
      required this.userId});

  Map<String, dynamic> toMap() => {
        'title': title,
        'amount': amount,
        'isExpense': isExpense,
        'date': date.toString(),
        'user_id': userId
      };

  factory TransactionModel.fromMap(Map<String, dynamic> value) =>
      TransactionModel(
          id: value['id'],
          title: value['title'],
          amount: value['amount'].toDouble(),
          isExpense: value['isExpense'],
          date: DateTime.parse(value['date']),
          userId: value['user_id']);
}
