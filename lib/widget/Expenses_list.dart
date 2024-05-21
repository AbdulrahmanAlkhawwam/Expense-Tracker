import 'package:acodemind02/main.dart';
import 'package:acodemind02/widget/Expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Expense.dart';

class Expenses_list extends StatelessWidget{
  const Expenses_list ({super.key, required this.expenses, required this.removeExpense});

  final List <Expense> expenses ;
  final void Function(Expense expense) removeExpense;


  @override
  Widget build (BuildContext context){
    return ListView.separated(
        itemBuilder: (context, index)=>Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            margin: const EdgeInsetsDirectional.symmetric(vertical: 5,horizontal: 16),
            color: Theme.of(context).colorScheme.error,
            child: Center(
              child: Text (
                  "DELETE",
                style: const TextStyle().copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  color: kColorScheme.errorContainer
                )
              ),
            ),
            /*color: Colors.redAccent,*/
          ),

            confirmDismiss: (DismissDirection direction) async {
            removeExpense(expenses[index]);
            return true;
            },
          child: Expenses_item(expense: expenses[index]),
        ),
        separatorBuilder: (context, index)=>const SizedBox(height: 10,),
        itemCount: expenses.length
    );
  }
}