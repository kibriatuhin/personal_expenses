import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/custom_widgets/add_icons.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/utilities/constant.dart';
import 'package:personal_expenses/widgets/cart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
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
      home: const MainApp(),
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
  bool _showChart = false;
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
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  //remove transactions
  void _deleteTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  //LandScap mode
  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txListWidgets) {
    return [
      Row(
        children: [
          const Text("Show Chart"),
          Switch(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Cart(recentTransactions: _recentTransactions),
            )
          : txListWidgets
    ];
  }

  //portrait mode
  List<Widget> _buildPortaitContent(
      MediaQueryData mediaQuery, AppBar appbar, Widget txListWidgets) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Cart(recentTransactions: _recentTransactions),
      ),
      txListWidgets
    ];
  }

  @override
  Widget build(BuildContext context) {
    //print('build() in main class');
    final mediaQuery = MediaQuery.of(context);
    final isLandScop = mediaQuery.orientation == Orientation.landscape;

    final appbar = AppBar(
      // backgroundColor: Color(0xff0868de),
      title: appbarTitle,
      actions: [
        IconButton(
          onPressed: () => _showModalBottomSheet(),
          icon: const AddIcon(
            iconData: Icons.add,
          ),
        )
      ],
    );
    //transaction list
    final txListWidgets = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionsList(
          userTransactions: _userTransactions,
          deleteTransaction: _deleteTransactions),
    );

    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandScop)
                ..._buildLandScapeContent(mediaQuery, appbar, txListWidgets),
              if (!isLandScop)
                ..._buildPortaitContent(mediaQuery, appbar, txListWidgets),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showModalBottomSheet(),
          child: const Icon(Icons.add),
        ));
  }
}
