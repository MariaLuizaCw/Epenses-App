import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // *** new data ***
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              // title
              controller: _titleControler,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              // value
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueControler,
              // onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Value (R\$)',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : 'Date: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _showDatePicker,
                    child: Text(
                        _selectedDate == null ? 'Select date' : 'Change date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              // button
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('New transaction'),
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitForm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
