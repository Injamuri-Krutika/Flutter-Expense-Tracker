import 'package:flutter/foundation.dart';

class Transaction {
  @required
  final String id;
  @required
  final String title;
  @required
  final double amount;
  @required
  final DateTime dateTime;

  Transaction({this.id, this.title, this.amount, this.dateTime});
}
