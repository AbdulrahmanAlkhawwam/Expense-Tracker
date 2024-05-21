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
    setState(() {
      _selectedDate = pickedDate ;
    });
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
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text(
              "New Expenses",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600
              ),
            ),
            const SizedBox(height: 20,),
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
                const SizedBox(width: 15),
                Expanded(
                  child: IconButton(
                    icon:const  Row (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text (
                          "Selected Date",
                          style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(width: 5,),
                        Icon(Icons.date_range)
                      ],
                    ),
                    onPressed: (){
                      _presentDataPicker();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row (children: [
              const Text(
                "Select Category for Expenses : ",
                style: TextStyle(
                  fontSize: 17.5,
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
            Row (
              children: [
               Expanded(
                 child: TextButton(
                     onPressed: (){Navigator.pop(context);},
                     child: const Text("cancel")
                 ),
               ),
                Expanded(
                  child: ElevatedButton(
                      style: const ButtonStyle(
                          //backgroundColor: MaterialStateColor.resolveWith((states) => Colors.indigo)
                      ),
                      onPressed: () {
                        setState(() {
                          _submitExpenseData();
                        });
                      },
                      child: const Text ("Save Expense",style: TextStyle(/*color: Colors.white*/),)
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}