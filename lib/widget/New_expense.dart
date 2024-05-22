import 'package:acodemind02/BoundedListView.dart';
import 'package:acodemind02/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Expense.dart';

class New_expense extends StatefulWidget{
  const New_expense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense ;

  @override
  State<New_expense> createState() => _New_expenseState();
}

class _New_expenseState extends State<New_expense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate ;

  Future<void> _presentDataPicker () async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year-1,now.month,now.day),
      lastDate: now,
      initialDate: now,
    );
    setState(() => _selectedDate = pickedDate);
  }

  void _submitExpenseData (){
    if (_titleController.text.trim().isEmpty || double.parse(_amountController.text) <=0 || _selectedDate == null){
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("invalid Error"),
          content: const Text ("Please ... make sure for Title , Amount and Date :)"),
          actions: [
            TextButton(
              child: const Text("Fix Error"),
              onPressed: ()=> Navigator.pop(ctx),
            )
          ],
        ),
      );
      return ;
    }
    widget.onAddExpense(Expense(title: _titleController.text, category: _selectedCategory, amount: double.parse(_amountController.text), date: _selectedDate as DateTime));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build (BuildContext context){
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
            padding: MediaQuery.of(context).size.width <=600
                ? EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16)
                : EdgeInsets.fromLTRB(48, 16, 48, keyboardSpace + 16),
            child: BoundedListView(
              children:  [
                const Text(
                  "New Expenses",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                  ),
                ),
                if (MediaQuery.of(context).size.width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                      child: TextField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text("Title"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map(
                              (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                  category.name.toUpperCase()
                              )
                          )
                      ).toList(),
                      onChanged: (value) {
                        if (value== null ) return ;
                        setState(()=>_selectedCategory = value);
                      },
                    ),
                  ],)
                else
                TextField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    IconButton(
                      icon: Row (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text (
                            "Selected Date",
                            style: const TextStyle().copyWith(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w400,
                                color: Brightness.dark!=MediaQuery.of(context).platformBrightness?kColorScheme.onSecondaryContainer:kDarkColorScheme.onSecondaryContainer
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Icon(Icons.date_range,color: Brightness.dark!=MediaQuery.of(context).platformBrightness?kColorScheme.onSecondaryContainer:kDarkColorScheme.onSecondaryContainer,)
                        ],
                      ),
                      onPressed: (){
                        _presentDataPicker();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                if (MediaQuery.of(context).size.width <= 600)
                Row (
                  children: [
                  Text(
                    "Select Category for Expenses : ",
                    style: const TextStyle().copyWith(
                        fontSize: 17.5,
                        color: Brightness.dark!=MediaQuery.of(context).platformBrightness?kColorScheme.onSecondaryContainer:kDarkColorScheme.onSecondaryContainer
                    ),
                  ),
                  const Spacer(),
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map(
                            (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                                category.name.toUpperCase()
                            )
                        )
                    ).toList(),
                    onChanged: (value) {
                      if (value== null ) return ;
                      setState(()=>_selectedCategory = value);
                    },
                  ),
                  const Spacer(),
                ],
                ),
                const Spacer(),
                Padding(
                  padding: MediaQuery.of(context).size.width<600 ?const EdgeInsets.all(0):const EdgeInsets.symmetric(horizontal: 25),
                  child: Row (
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){Navigator.pop(context);},
                            child: const Text("cancel")
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => setState(() => _submitExpenseData()),
                            child: const Text (
                              "Save Expense",
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        );
      },);
  }
}