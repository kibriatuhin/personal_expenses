import 'package:flutter/material.dart';
import 'package:personal_expenses/custom_widgets/add_icons.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/utilities/constant.dart';
import 'package:personal_expenses/widgets/cart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DateTime? _pickedDate;
  List<Transactions> _userTransactions = [
    // Transactions(id: "id1", title: "Shirt", amount: 5.5, dateTime: DateTime.now())
  ];

  //add new Transaction
  void _addNewTransactions(
      String txTitle, double txAmount, DateTime txDateTime) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        dateTime: txDateTime);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //modal sheet
  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTransactions(addNewTransaction: _addNewTransactions);
        });
  }

  //recent transactions
  List<Transactions> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  //remove transactions
  void _deleteTransactions( String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff0868de),
          title: appbarTitle,
          actions: [
            IconButton(
              onPressed: () => _showModalBottomSheet(),
              icon: AddIcon(
                iconData: Icons.add,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //NewTransactions(addNewTransaction: _addNewTransactions,),
              Cart(recentTransactions: _recentTransactions),
              TransactionsList(userTransactions: _userTransactions,deleteTransaction: _deleteTransactions)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showModalBottomSheet(),
          child: Icon(Icons.add),
        ));
  }
}
