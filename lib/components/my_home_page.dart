import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import 'chart.dart';

class ExpensesViewer extends StatelessWidget {
  final double limit;
  final double weekTotal;
 
  ExpensesViewer(this.weekTotal, this.limit);
  @override
  Widget build(BuildContext context) {
    final double limitLeft = limit-weekTotal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'R\$ $limitLeft',
                    
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Text(
                  'You still have ${limitLeft/limit * 100}% of your limit available',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
            
                )
              ],
            ))
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  final double limit;
  MyHomePage(this.limit);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool viewExpenses = false;



  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _changeHomeBody() {
    setState(() {
      viewExpenses = !viewExpenses;
    });
  }

  _addTransaction(String title, double value, DateTime date, String category) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
      category: category,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    
    Chart chart = Chart(_recentTransaction, widget.limit);
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: Icon(viewExpenses ? Icons.home : Icons.view_agenda),
            onPressed: _changeHomeBody,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _opentransactionFormModal(context),
          )
        ],
      ),
      body: viewExpenses
          ? ExpensesViewer(chart.weekTotalValue, widget.limit)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  chart,
                  TransactionList(_transactions, _deleteTransaction),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
