import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Cart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  const Cart({required this.recentTransactions});

  List<Map<String, dynamic>> get groupedTransactionsValue {
    return List.generate(
      7,
      (index) {
        final weakDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].dateTime.day == weakDay.day &&
              recentTransactions[i].dateTime.month == weakDay.month &&
              recentTransactions[i].dateTime.year == weakDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weakDay).substring(0, 1),
          'amount': totalSum
        };
      },
    ).reversed.toList();
  }

  // max spending
  double get maxSpending {
    return groupedTransactionsValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
   // print('build() in chart class');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Total spending of weak: $maxSpending'),
            ),
          ),
        ),*/
        Card(
          elevation: 6,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: groupedTransactionsValue.map((e) {
                return ChartBar(
                    label: e['day'],
                    spendingAmount: e['amount'],
                    spendingOfTotal: maxSpending == 0.0
                        ? 0.0
                        : (e['amount'] as double) / maxSpending);
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
