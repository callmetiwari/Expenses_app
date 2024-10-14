import 'package:flutter/material.dart';
import 'package:expenses_app/modals/expense.dart';
import 'package:expenses_app/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpenses});
  final void Function(Expense expense) onAddExpenses;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /*var _enteredTitle = '';
  void _saveTitleInput(String InputValues) {
    _enteredTitle = InputValues;
  }*/
  final _titlecontroller = TextEditingController();
  final _amountcontroller1 = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastdate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastdate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpensesData() {
    final _enteredAmount = double.tryParse(_amountcontroller1.text); //try parse
    //  return a null if string is empty(not containg the numbers only) else it converts the number to double
    final amountisValid = _enteredAmount == null || _enteredAmount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountisValid ||
        _selectedDate == null) {
      //show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Your Input in invaild'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpenses(Expense(
        title: _titlecontroller.text,
        amount: _enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            //  affecting enterTitle;  // onChanged: _saveTitleInput,
            controller: _titlecontroller,
            maxLength: 20,
            decoration: const InputDecoration(
                label: Text("enter the name of goods and services used")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: '\$ ', label: Text("Enter the amount")),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'NO date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentdatepicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              //const SizedBox(height: 20),
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: _submitExpensesData, child: const Text('ADD')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
