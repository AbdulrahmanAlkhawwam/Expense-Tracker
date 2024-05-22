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
      useSafeArea: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => New_expense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense (Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense (Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
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
            onPressed: () => setState(() => _registeredExpenses.insert(expenseIndex,expense))),
      ),
    );
  }

  @override
  Widget build (BuildContext context){
    double width = MediaQuery.of(context).size.width;
    late Widget mainContent ;
    if (_registeredExpenses.isEmpty){
      mainContent = const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_gmailerrorred,
            size: 150,
          ),
          Center(
            child: Text(
              "There are no Expenses found :(\n\t\t\t\t\t\t\t Start adding some !",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      );
    }
    else {
      if (width < 600){
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
      else
        {
          mainContent =
              Row(
                children: [
                  Expanded(
                      child: Chart(
                          expenses: _registeredExpenses,
                      ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Expenses_list(
                        expenses: _registeredExpenses,
                        removeExpense: _removeExpense,
                      ),
                    ),
                  ),
                ],
              );

        }
     }

    return Scaffold(
      appBar: AppBar(
        title: const Text (
          "Flutter Expenses Tracker",
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpensesOverlay,
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: mainContent
    );
  }
}