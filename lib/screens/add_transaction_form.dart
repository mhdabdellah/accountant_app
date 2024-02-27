import 'package:accountant_app/custom_widgets/button.dart';
import 'package:accountant_app/custom_widgets/input.dart';
import 'package:accountant_app/custom_widgets/radio_button.dart';
import 'package:accountant_app/helpers/localization.dart';
import 'package:accountant_app/providers/add_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AddTransactionForm extends StatelessWidget {
  const AddTransactionForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AddTransactionProvider(), child: _AddTransactionForm());
  }
}

class _AddTransactionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addTransactionProvider = context.watch<AddTransactionProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 0.0, right: 16.0, left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 300, width: 300, child: Lottie.asset("assets/logo.json")),
          Input(
            controller: addTransactionProvider.titleController,
            keyboardType: TextInputType.text,
            label: ApplicationLocalization.translator!.title,
            iconData: Icons.description,
          ),
          Input(
            controller: addTransactionProvider.amountController,
            keyboardType: TextInputType.number,
            label: ApplicationLocalization.translator!.amount,
            iconData: Icons.attach_money,
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text(ApplicationLocalization.translator!.type),
              Expanded(
                child: RadioButton(
                  title: ApplicationLocalization.translator!.expense,
                  value: 'Expense',
                  groupValue: addTransactionProvider.selectedType,
                  onChanged: (value) {
                    if (value != null) {
                      addTransactionProvider.setTypeValue(value);
                    }
                  },
                ),
              ),
              Expanded(
                child: RadioButton(
                  title: ApplicationLocalization.translator!.income,
                  value: 'Income',
                  groupValue: addTransactionProvider.selectedType,
                  onChanged: (value) {
                    if (value != null) {
                      addTransactionProvider.setTypeValue(value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Button(
            text: ApplicationLocalization.translator!.addTransaction,
            onPressed: () async {
              await addTransactionProvider.addTransaction();
            },
          ),
        ],
      ),
    );
  }
}
