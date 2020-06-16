import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    const Text(
                      'No transactions available',
                      style: TextStyle(
                          fontFamily: 'Opensans', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.4,
                      child: Image.asset(
                        "images/waiting.png",
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                );
              })
            : ListView(
                children: transactions
                    .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx))
                    .toList()));
  }
}
