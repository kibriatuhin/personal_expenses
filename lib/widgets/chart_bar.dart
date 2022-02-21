import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingOfTotal;

  ChartBar({
    required this.label,
    required this.spendingAmount,
    required this.spendingOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*SizedBox(
            height: constrains.maxHeight * 0.05,
          ),*/
        Container(
          height: 15,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
            height:4
        ),
        Container(
            height: 15,
            child: FittedBox(child: Text(label)))
      ],
    );
  }
}
