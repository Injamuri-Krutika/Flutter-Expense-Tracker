import 'package:ExpenseTracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues
                .map((tx) {
                  double spendingPercentage = totalSpending == 0.0
                      ? 0.0
                      : (tx['amount'] as double) / totalSpending;
                  return ChartBar(tx['day'], tx['amount'], spendingPercentage);
                })
                .toList()
                .reversed
                .toList(),
          ),
        ),
      ),
    );
  }
}
