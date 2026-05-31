import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ledgerly/chart/charts.dart';
import 'package:ledgerly/main.dart';
import 'package:lottie/lottie.dart';
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
  String? gretingtitle;
  String? sub;


  void gretingtitlefn() {
    final int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      gretingtitle = 'Good Morning!';
      sub = 'Track your morning spending.';
    }
    else if (hour >= 12 && hour < 17) {
      gretingtitle = 'Good Afternoon! ';
      sub = 'Managing your day\'s budget?';
    }
    else if (hour >= 17 && hour < 19) {
      gretingtitle = 'Good Evening! ';
      sub = 'Review your daily balance.';
    }
    else {
      gretingtitle = 'Welcome back!';
      sub = 'Plan your tomorrow today.';
    }
  }
  @override
  void initState() {
    super.initState();
    gretingtitlefn();
  }
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screnWidth= MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
    final heigth=MediaQuery.of(context).size.height;
    Widget maincontext= Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,15,0,5),
            child: Lottie.asset("lib/images/cycle_coin.json", height: screenHeight * 0.09, fit: BoxFit.contain,frameRate: FrameRate(3000),repeat:true),
          ),

          Text('Your expense list is empty. Tap + to add one!',style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: (screnWidth * 0.038).roundToDouble().clamp(14, 20)),),
        ],
      )),
    );
    if(_registredexpenses.isNotEmpty){

        maincontext = Expanded(child: Container(child: Expense_List(expenseslist: _registredexpenses, removeExpense: removeExpense,)));
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
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$gretingtitle\n\n', // The \n moves the subtitle to the next line naturally
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold, // Makes the title bold
                      height: 0.6, // Tightly packs the line
                    ),
                  ),

                  TextSpan(
                    text: '$sub',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 13, // Slightly smaller size
                      fontWeight: FontWeight.bold, // Not bold
                      //height: 1.1, // Controls the exact distance from the title
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,8,8,8),
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
          mainAxisAlignment: MainAxisAlignment.start,//_registredexpenses.isNotEmpty?MainAxisAlignment.start:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(expenses: _registredexpenses),
            const SizedBox(height: 10,),
            maincontext
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


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /*bottomNavigationBar: BottomAppBar(
        height: (screenHeight * 0.083).clamp(60.0, 90.0),
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
      ),*/
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