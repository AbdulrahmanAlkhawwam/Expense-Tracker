import 'package:flutter/material.dart';
import 'package:acodemind02/models/Expense.dart';

class Expenses_item extends StatelessWidget {
  const Expenses_item({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(expense.title,
                      style: const TextStyle(
                          fontSize: 22.5, fontWeight: FontWeight.w500)
                      ,),
                    const Spacer(),
                    Icon(
                      categoryIcon[expense.category],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "\$ ${expense.amount}",
                    ),
                    const Spacer(),
                    Text(
                      expense.formattedDate,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}