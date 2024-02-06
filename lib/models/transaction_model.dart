class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final bool isExpense; // true for expense, false for income
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.date,
  });

  // 'Expense' to 'Map'
  Map<String, dynamic> toMap() => {
        // id will generate automatically
        'title': title,
        'amount': amount,
        'isExpense': isExpense,
        'date': date.toString(),
      };

  // 'Map' to 'Expense'
  factory TransactionModel.fromJson(Map<String, dynamic> value) =>
      TransactionModel(
          id: value['id'],
          title: value['title'],
          amount: value['amount'].toDouble(),
          isExpense: value['isExpense'],
          date: DateTime.parse(value['date']));
}
