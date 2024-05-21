import 'package:acodemind02/widget/Chart.dart';
import 'package:acodemind02/widget/Expenses_list.dart';
import 'package:acodemind02/widget/New_expense.dart';
import 'package:flutter/material.dart';
import 'models/Expense.dart';

class Expenses extends StatefulWidget {
  const Expenses ({super.key});

  @override
  State<Expenses> createState (){
    return _ExpensesState();
  }
}



class _ExpensesState extends State<Expenses>{
  final List <Expense> _registeredExpenses =[];

  void _openAddExpensesOverlay (){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => New_expense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense (Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
      print (_registeredExpenses.toList().toString());
    });
  }

  void _removeExpense (Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
      print (_registeredExpenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: const Text(
          "Expense Deleted"
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex,expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build (BuildContext context){
    late Widget mainContent ;
    if (_registeredExpenses.isEmpty){
      mainContent =  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_gmailerrorred,
            size: 150,
            /*color: Colors.grey.shade400,*/
          ),
          Center(
            child: Text(
              "There are no Expenses found :(\n\t\t\t\t\t\t\t Start adding some !",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                /*color: Colors.grey.shade400*/
              ),
            ),
          ),
        ],
      );
    }
    else {
      mainContent =
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chart(expenses: _registeredExpenses),
              Expanded(
                child: Expenses_list(
                  expenses: _registeredExpenses,
                  removeExpense: _removeExpense,
                ),
              ),
            ],
          );
    }

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.indigo,
        title: const Text (
          "Flutter Expenses Tracker",
           style: TextStyle(
             /*  color: Colors.white*/
           ),
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpensesOverlay,
              icon: const Icon(Icons.add,/*color: Colors.white,*/)
          )
        ],
      ),
      body: mainContent
    );
  }
}