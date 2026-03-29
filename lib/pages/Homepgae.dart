import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledgerly/chart/charts.dart';
import 'package:ledgerly/main.dart';
import '../ExpenseList/Expense_List.dart';
import '../Model/expense_model.dart';
import 'Add_new_expense.dart';

class Homepgae extends StatefulWidget{
  Homepgae({required this.AppTheme,super.key});
  final void Function (String mode) AppTheme;
  @override
  State<Homepgae> createState() => _HomepgaeState();
}

class _HomepgaeState extends State<Homepgae> {
  final List<expense_model> _registredexpenses=[];

  void addExpense(expense_model expense){
    setState(() {
      _registredexpenses.add(expense);
    });
  }

  void removeExpense(expense_model expense){
    final expenseIndex=_registredexpenses.indexOf(expense);
    setState(() {
      _registredexpenses.remove(expense);
    });
   ScaffoldMessenger.of(context).clearSnackBars();
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text('Expense Deleted'),
     duration: Duration(seconds: 3),
     action: SnackBarAction(label: 'Undo',onPressed: (){setState(() {
         _registredexpenses.insert(expenseIndex, expense);
       });}, textColor:Colors.indigoAccent,),
       showCloseIcon: true,
     )
   );
  }

  void openAddExpenseOverlay(){

  showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, builder: (ctx) => AddNewExpense(addnewexpense: addExpense,));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth=MediaQuery.of(context).size.height;
    Widget maincontext= Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("lib/images/rabit-removebg-preview.png",scale: 2.5,),
          Text('No expense Found start Adding some..!',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 15),),
        ],
      )),
    );
    if(_registredexpenses.isNotEmpty){

        maincontext = Expense_List(expenseslist: _registredexpenses, removeExpense: removeExpense,);
    }
    return Scaffold(

      appBar: AppBar(

        backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
        shadowColor:Theme.of(context).appBarTheme.shadowColor,
        elevation:5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
            child: Icon(Icons.person_2),
            backgroundColor: Theme.of(context).primaryColor ,
          ),
        ),
        title: RichText(text:TextSpan(
          style: Theme.of(context).textTheme.headlineMedium,
            children: [
            TextSpan(text: "Welcome Back..!\n", ),
            TextSpan(text: 'Track your expenses,start your day right',style: Theme.of(context).textTheme.headlineSmall)
          ]
        ) ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon:  Theme.of(context).brightness == Brightness.dark ? Icon(Icons.light_mode_rounded):Icon(Icons.dark_mode_rounded,color: Colors.black,),
              onPressed: () {
                if (Theme.of(context).brightness == Brightness.dark) {
                  widget.AppTheme('light');
                } else {
                  widget.AppTheme('dark');
                }
              },
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.yellow:Colors.black),
                tooltip: 'change theme',
                autofocus: true,
                focusColor: Colors.deepPurpleAccent,
                iconSize:30 ,
            ),
          )
        ],
      ),

      body: Container(
        height: heigth,
        width:  width,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: _registredexpenses.isNotEmpty?MainAxisAlignment.start:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(expenses: _registredexpenses),
            const SizedBox(height: 10,),
            Expanded(
             child: Container(
             child: maincontext,
                      ),
           )
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed:openAddExpenseOverlay ,
        child: Icon(Icons.add_rounded,size:25,),
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
        splashColor: Theme.of(context).floatingActionButtonTheme.splashColor,
        hoverColor: Theme.of(context).floatingActionButtonTheme.hoverColor,
        elevation: 5,
        shape: Theme.of(context).floatingActionButtonTheme.shape,
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height:70,
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           /* Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(Icons.home_filled),
                  Text('Home')
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

class ExpenseBucket{
  ExpenseBucket({required this.category,required this.expenses});

  // this allows to calculate teh expenses belong to same category
  // this is the known as teh alternative constructor
  ExpenseBucket.forCategory(List <expense_model> expenses,this.category)
      : expenses=expenses.where((expense) => expense.category==category).toList();


  final Category category;
  final  List<expense_model> expenses;
  double get totalExpenses{
    double sum=0;
    for( final expense in expenses){
      sum +=expense.amount;
    }
    return sum;
  }

}