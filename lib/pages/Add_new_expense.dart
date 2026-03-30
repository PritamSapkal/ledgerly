import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ledgerly/Model/expense_model.dart';

class AddNewExpense extends StatefulWidget{
  AddNewExpense({required this.addnewexpense,super.key});
  void Function (expense_model expense) addnewexpense;

  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  var title= TextEditingController();
  var amount= TextEditingController();
  DateTime ? selecteddate=null;
  var selectedcategory = Category.food;

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double screenheight= MediaQuery.of(context).size.height;
    double screenwidth=MediaQuery.of(context).size.width;

    void Selectdate()async{
      var date = await showDatePicker(context: context,
          initialDate:DateTime.now() ,
          firstDate: DateTime(DateTime.now().year-1,DateTime.now().month,DateTime.now().day),
          lastDate: DateTime.now()
      );
      setState(() {
        selecteddate=date;
      });
    }

    void submitexpense(){
      var enteredamount = double.tryParse(amount.text);
      var invalidamount= enteredamount==null || enteredamount<=0;
      if(title.text.trim().isEmpty||invalidamount||selecteddate==null){
        showDialog(context: context, builder:(context) => AlertDialog(
          backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
          title: Text('Invalid Data',style: Theme.of(context).dialogTheme.titleTextStyle,),
          content: Text('Please make sure a valid description,amount and date was entered..',style: Theme.of(context).dialogTheme.contentTextStyle,),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Okay'))
          ],
        ),);
        return;
      }
      widget.addnewexpense(expense_model(title:title.text , amount: enteredamount, date: selecteddate!, category: selectedcategory));
      Navigator.pop(context);
    }


    return Container(
      width: screenwidth,
      height: screenheight,
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,10,0,0),
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close,size: 30,color: Colors.black,))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10),
              child: Text( "Add new expense",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: (screenwidth * 0.064).roundToDouble().clamp(22, 32)),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 10),
              child: Text( 'Enter the details of your expense to help you \ntrack your spending.',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: (screenwidth * 0.038).roundToDouble().clamp(14, 20),fontWeight:FontWeight.bold)),
            ),
            LedgerlyTextField(
              controller:amount,
              icon: Icons.attach_money_outlined ,
              keyboardType: TextInputType.numberWithOptions(),
              title: 'Enter Amount',maxlenth: 10,styleoftitle:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.033).roundToDouble().clamp(12, 18)) ,
              styleoftext: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.046).roundToDouble().clamp(16, 24)),),
            LedgerlyTextField(
              controller:title,
              icon: Icons.title_outlined ,
              keyboardType: TextInputType.text,title: 'Description',maxlenth: 50,styleoftitle:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.033).roundToDouble().clamp(12, 18)) ,
              styleoftext:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.046).roundToDouble().clamp(16, 24)) ,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,25,20,10),
              child: Text('Category',textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.033).roundToDouble().clamp(12, 18)),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Container(
                height: (screenheight * 0.065).clamp(60.0, 90.0),
                decoration: BoxDecoration(
                  color:  Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<Category>(
                    value: selectedcategory,
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
                    items: Category.values.map((category) => DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            categoryIcons[category],
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(width: 40),
                          Text(
                            category.name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: (MediaQuery.sizeOf(context).shortestSide * 0.038),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedcategory = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,25,20,0),
              child: Text('Select Date',textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.033).roundToDouble().clamp(12, 18)),),
            ),
            InkWell(
              onTap: Selectdate,
              child:Padding(
                padding: const EdgeInsets.fromLTRB(20,10,20,10),
                child: Container(
                  height:60,
                  decoration: BoxDecoration(
                    // 1. The Grey Fill (Match your TextField opacity)
                    color:Colors.grey.withOpacity(0.2),

                    // 2. Rounded Corners
                    borderRadius: BorderRadius.circular(15),

                    // 3. Optional: A very subtle border for Dark Mode
                    border: Border.all(
                      color: Colors.white.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: Text(selecteddate==null ? 'No Date selected': DateFormat('dd/MM/yyyy').format(selecteddate!),style:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: (screenwidth * 0.038).roundToDouble().clamp(14, 20)),),
                        ),
                        Spacer(),
                        Icon(Icons.calendar_month_rounded)
                      ],
                    ),
                  ),
                ),
              ),

            ),
            InkWell(
              onTap: submitexpense,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,50,20,50),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height:(screenheight * 0.073).clamp(60.0, 90.0),
                    decoration: BoxDecoration(
                      color:Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text('Add  Expense',style:GoogleFonts.poppins(color: Theme.of(context).primaryColorLight,fontSize: (screenwidth * 0.038).roundToDouble().clamp(14, 20),fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LedgerlyTextField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String title;
  final int maxlenth;
  TextStyle ? styleoftitle;
  TextStyle? styleoftext;

   LedgerlyTextField({
    super.key,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.title,
    required this.maxlenth,
    required this.styleoftitle,
    required this.styleoftext
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(title,textAlign: TextAlign.start,style: styleoftitle,),),

          TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxlenth,
            style: styleoftext,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.indigoAccent),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              // 1. Default Border (When not selected)
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),

              // 2. Focus Border (When the user clicks it)
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.indigoAccent, width: 2),
              ),

              contentPadding: const EdgeInsets.all(20),
            ),
          ),
        ],
      ),
    );
  }
}

/*
* ThemeData buildResponsiveTheme(BuildContext context) {
  // shortestSide prevents text from blowing up in Landscape mode
  double s = MediaQuery.of(context).size.shortestSide;

  return ThemeData(
    textTheme: TextTheme(
      // 35 Size
      displayLarge: TextStyle(fontSize: (s * 0.090).roundToDouble().clamp(30, 48)),

      // 25 Size
      headlineLarge: TextStyle(fontSize: (s * 0.064).roundToDouble().clamp(22, 32)),

      // 20 Size
      headlineMedium: TextStyle(fontSize: (s * 0.051).roundToDouble().clamp(18, 26)),

      // 18 Size (New!)
      titleLarge: TextStyle(fontSize: (s * 0.046).roundToDouble().clamp(16, 24)),

      // 17 Size
      titleMedium: TextStyle(fontSize: (s * 0.044).roundToDouble().clamp(15, 22)),

      // 15 Size
      bodyLarge: TextStyle(fontSize: (s * 0.038).roundToDouble().clamp(14, 20)),

      // 13 Size
      bodyMedium: TextStyle(fontSize: (s * 0.033).roundToDouble().clamp(12, 18)),

      // 12 Size
      bodySmall: TextStyle(fontSize: (s * 0.030).roundToDouble().clamp(11, 16)),
    ),
  );
}*/


