import 'package:expenses_app/modals/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(expense.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 50),
          Row(
            children: [
              // Text(expense.amount.toStringAsFixed(2)),
              Text('\$ ${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  // Text(expense.category.toString()),
                  const SizedBox(width: 8),
                  Text(expense.formattedDate),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
