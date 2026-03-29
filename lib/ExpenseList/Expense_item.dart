import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledgerly/Model/expense_model.dart';

class ExpenseItem extends StatelessWidget{
   const ExpenseItem({super.key, required this.expense});
  final expense_model expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child:ListTile(
        leading: Container(
           decoration: BoxDecoration(
             shape:BoxShape.circle,
             border: Border.all(
               width:0.5,
               color: Colors.orange
             )
           ),
            child:CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(categoryIcons[expense.category]),)
        ),
        title: Text(expense.title,style: Theme.of(context).textTheme.titleLarge,) ,
        subtitle: Text(expense.formattedDate,style: Theme.of(context).textTheme.titleMedium,),
         trailing:Text('₹ '+ expense.amount.toString(),style: Theme.of(context).textTheme.titleSmall,),
      ) ,
    );
  }
}