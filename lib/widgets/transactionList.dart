import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transactions available',
                    style: TextStyle(
                        fontFamily: 'Opensans', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      "images/waiting.png",
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, idx) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                  child:
                                      Text('\$${transactions[idx].amount}')))),
                      title: Text(
                        transactions[idx].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[idx].dateTime),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[idx].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
