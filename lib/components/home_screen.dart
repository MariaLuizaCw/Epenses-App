import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(double) setLimit;

  HomeScreen(this.setLimit);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _limitController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    //print(_limitController.text);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Qual é seu limite de gastos?',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            width: 200,
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                controller: _limitController,
                onSubmitted: (_) {
                  return widget.setLimit(double.tryParse(_limitController.text) ?? 0.0);
                },
            ),
          )
        ],
      ),
    ));
  }
}