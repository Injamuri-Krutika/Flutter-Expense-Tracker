import 'package:flutter/cupertino.dart';
import './new_transaction.dart';
import './transactionList.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     NewTransaction(_addNewTransaction),
    //   ],
    // );
  }
}
