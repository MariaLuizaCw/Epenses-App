import 'package:flutter/foundation.dart';


class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.value,
    @required this.date,
    @required this.title
  });
}