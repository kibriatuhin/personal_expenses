import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final void Function(String txTitle, double txAmount, DateTime txdateTime)?
      addNewTransaction;
  NewTransactions({required this.addNewTransaction});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  DateTime? _pickedDate;

  final titleController = TextEditingController();
  final amountConrtoller = TextEditingController();

//date picker
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedtx) {
      if (pickedtx == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedtx;
      });
    });
  }

  //submitted data
  void _submittedData() {
    if (amountConrtoller.text.isEmpty) {
      return;
    }
    final enterAmount = double.parse(amountConrtoller.text.toString());
    if (titleController.text.isEmpty ||
        enterAmount <= 0 ||
        _pickedDate == null) {
      return;
    }
    widget.addNewTransaction!(titleController.text, enterAmount, _pickedDate!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_)=> _submittedData,
              //onChanged: (value)=>  titletx = value,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter title",
                icon: Icon(Icons.title),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: amountConrtoller,
              onSubmitted: (_)=> _submittedData,
              //onChanged: (value)=> amountTx = value,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "Enter amount",
                icon: Icon(Icons.attach_money_outlined),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? "No date selected"
                          : "Selected Date: ${DateFormat.yMd().format(_pickedDate!)}",
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "Choose Date",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submittedData();
                //addNewTransaction(titleController.text,double.parse(amountConrtoller.text),_pickedDate);
              },
              child: Text("Add Transaction"),
            ),
          ],
        ),
      ),
    );
  }
}
