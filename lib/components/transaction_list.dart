import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final void Function(Transaction) onUndo;
  TransactionList(this.transactions, this.onRemove, this.onUndo);

  @override
  Widget build(BuildContext context) {
    Widget stackBehindDismiss() {
      return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        color: Theme.of(context).accentColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      );
    }

    return Container(
      height: 565,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "You haven't added any transaction.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Dismissible(
                  background: stackBehindDismiss(),
                  key: ObjectKey(tr),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              '${tr.value}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y').format(tr.date),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    var item = transactions.elementAt(index);
                    onRemove(tr.id);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Item deleted"),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () => onUndo(item),
                        ),
                      ),
                    );
                  },
                );
              }
              // transactions list
              ),
    );
  }
}
