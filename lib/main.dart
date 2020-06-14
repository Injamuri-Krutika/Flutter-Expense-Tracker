import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transactionList.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracker",
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Opensans',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white))),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    //   Transaction(
    //       id: 't1', title: "Purse", amount: 150, dateTime: DateTime.now()),
    //   Transaction(
    //       id: 't2', title: "Laptop", amount: 150000, dateTime: DateTime.now()),
    //   Transaction(
    //       id: 't3', title: "Table", amount: 45620, dateTime: DateTime.now()),
    //   Transaction(
    //       id: 't4', title: "Pav Bhaji", amount: 50, dateTime: DateTime.now()),
    //   Transaction(
    //       id: 't5', title: "Sofa", amount: 12350, dateTime: DateTime.now()),
    //   Transaction(id: 't6', title: "Milk", amount: 44, dateTime: DateTime.now()),
    //   Transaction(id: 't7', title: "Beer", amount: 150, dateTime: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime pickedDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        dateTime: pickedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Expense Tracker"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top),
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isLandscape)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Show Chart'),
                          Switch.adaptive(
                              value: _showChart,
                              onChanged: (val) {
                                setState(() {
                                  _showChart = val;
                                });
                              })
                        ],
                      ),
                    if (!isLandscape)
                      Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.35,
                          child: Chart(_recentTransactions)),
                    if (!isLandscape) txListWidget,
                    if (isLandscape)
                      _showChart
                          ? Container(
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.7,
                              child: Chart(_recentTransactions))
                          : txListWidget
                  ]))),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
