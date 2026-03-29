import 'package:flutter/material.dart';
import 'package:ledgerly/ExpenseList/Expense_item.dart';

import '../Model/expense_model.dart';

class Expense_List extends StatefulWidget {
  Expense_List({super.key,required this.expenseslist, required this.removeExpense});
  final List<expense_model> expenseslist;
  void Function (expense_model) removeExpense;
  @override
  State<Expense_List> createState() => _Expense_ListState();
}

class _Expense_ListState extends State<Expense_List> {
  @override
  Widget build(BuildContext context) {
    var isDarkmode =MediaQuery.of(context).platformBrightness==Brightness.dark;
    return ListView.builder(itemBuilder:(context, index){
      return Padding(
        padding: const EdgeInsets.fromLTRB(15,5, 15, 0),
        child: Dismissible(
          key: ValueKey(widget.expenseslist[index]),
          onDismissed: (direction) => widget.removeExpense(widget.expenseslist[index]),
          child: ExpenseItem(expense: widget.expenseslist[index],),
          background: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkmode?Colors.red.withOpacity(0.8):Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),

              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: Icon(Icons.delete_rounded,color:Theme.of(context).iconTheme.color,),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,10,0),
                    child: Icon(Icons.delete_rounded,color:Theme.of(context).iconTheme.color,),
                  ),
                ],
              ),
            ),
          ),
          ),
      );
      },
    itemCount: widget.expenseslist.length,) ;
  }
}