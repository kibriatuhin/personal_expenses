import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/custom_widgets/big_text.dart';
import 'package:personal_expenses/custom_widgets/small_text.dart';
import 'package:personal_expenses/models/transactions.dart';

class TransactionsItem extends StatelessWidget {
  const TransactionsItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transactions userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text("\$${userTransaction.amount.toStringAsFixed(2)}"),
            ),
          ),
        ),
        title: BigText(text: userTransaction.title),
        subtitle: SmallText(
          text: DateFormat.yMMMd().format(userTransaction.dateTime),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
            size: 28,
          ),
          onPressed: () => deleteTransaction(userTransaction.id),
        ),
      ),
    );
  }
}