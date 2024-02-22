import 'package:accountant_app/helpers/utils.dart';
import 'package:accountant_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            border: Border.all(color: Colors.blue)),
        child: ExpansionTile(
          title: const Text(""),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${transaction.amount.toString()} ${AppLocalizations.of(context)!.mru}"),
              Text(transaction.isExpense
                  ? AppLocalizations.of(context)!.expense
                  : AppLocalizations.of(context)!.income),
            ],
          ),
          children: [
            ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                    ),
                    Text(
                      transaction.title,
                    )
                  ]),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.amount),
                  Text(
                      "${transaction.amount.toString()} ${AppLocalizations.of(context)!.mru}"),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.type),
                  Text(transaction.isExpense
                      ? AppLocalizations.of(context)!.expense
                      : AppLocalizations.of(context)!.income),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.date),
                  Text(Utils.convertDate(transaction.date)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
