import 'package:flutter/material.dart';

import 'components/home_screen.dart';
import 'components/my_home_page.dart';

main() => runApp(ExpensesApp());

class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  double _validLimit = 0.0;
  _settingLimit(double limit) {
    setState(() {
      _validLimit = limit;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_validLimit);
    return _validLimit == 0.0
        ? HomeScreen(_settingLimit)
        : MyHomePage(_validLimit);
  }
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenManager(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              headline1: TextStyle(
                color: Colors.purple,
                fontFamily: 'OpenSans',
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              headline3: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}
