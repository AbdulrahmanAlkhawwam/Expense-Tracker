import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

enum Category {
  food ,
  travel ,
  leisure ,
  work
}

Map <Category,IconData> categoryIcon ={
  Category.food : Icons.fastfood,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.gamepad,
  Category.work : Icons.work,
};

const uuid = Uuid ();

class Expense {
  late String id ;
  String title ;
  Category category ;
  double amount ;
  DateTime date ;

  Expense ({
    required this.title,
    required this.category,
    required this.amount,
    required this.date
  }): id = uuid.v4();

  String get formattedDate {
    return DateFormat.yMd().format(date);
  }
}
class ExpenseBucket {
  ExpenseBucket({required this.category,required this.expenses});

  ExpenseBucket.forCategory (List <Expense> allExpense ,this.category)
      :expenses = allExpense
      .where((expenses) => expenses.category == category)
      .toList();

  final Category category ;
  final List <Expense> expenses ;

  double get totalExpenses {
    double sum = 0 ;
    for (final expense in expenses){
      sum+=expense.amount;
    }
      return sum ;
  }

  forCategory(List<Expense> expenses, Category food) {

  }
}