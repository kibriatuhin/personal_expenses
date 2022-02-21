import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses/custom_widgets/big_text.dart';
import 'package:personal_expenses/custom_widgets/small_text.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> userTransactions;
  final Function deleteTransaction;

  TransactionsList({required this.userTransactions,required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 300,
      //height: MediaQuery.of(context).size.height * 0.6,
      child: userTransactions.isEmpty
          ? LayoutBuilder(builder: (ctx , constrains){
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "No transaction yet",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/image/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
      })
          : ListView.builder(
              itemCount: userTransactions.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              "\$${userTransactions[index].amount.toStringAsFixed(2)}"),
                        ),
                      ),
                    ),
                    title: BigText(text: userTransactions[index].title),
                    subtitle: SmallText(
                      text: DateFormat.yMMMd()
                          .format(userTransactions[index].dateTime),
                    ),
                    trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,size: 28,), onPressed: () => deleteTransaction(userTransactions[index].id),),
                  ),
                );
              },
            ),
    );
  }
}
/*
Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  child: Text(
                      "\$${userTransactions[index].amount.toStringAsFixed(2)}"),
                  decoration: BoxDecoration(
                      border: Border.all(
                       color: Theme.of(context).primaryColor,
                  )),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: userTransactions[index].title),
                    SmallText(
                        text: DateFormat.yMMMd()
                            .format(userTransactions[index].dateTime))
                  ],
                )
              ],
            )
*/
