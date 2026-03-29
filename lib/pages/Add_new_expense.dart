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

    final width = MediaQuery.of(context).size.width;
    final  height= MediaQuery.of(context).size.height;


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
      width: width,
      height: height,
      color: Theme.of(context).primaryColor,
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
            child: Text( "Add new expense",style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 25),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 10),
            child: Text( 'Enter the details of your expense to help you \ntrack your spending.',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 15,fontWeight:FontWeight.bold)),
          ),
          LedgerlyTextField(controller:amount,icon: Icons.attach_money_outlined ,keyboardType: TextInputType.numberWithOptions(),title: 'Enter Amount',maxlenth: 10,),
          LedgerlyTextField(controller:title,icon: Icons.title_outlined ,keyboardType: TextInputType.text,title: 'Description',maxlenth: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,25,20,10),
            child: Text('Category',textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 13),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,10),
            child: Container(
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
                child: DropdownButton<Category>(
                  value: selectedcategory,
                  isExpanded: true, // Makes it look better on mobile
                  underline: Container(), // Removes the default line for a cleaner look
                  items: Category.values.map((category) => DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Icon(categoryIcons[category]), // Use the mapping we made earlier
                        const SizedBox(width: 40),
                        Text(category.name.toUpperCase(),style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),),
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
            child: Text('Select Date',textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 13),),
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
                        child: Text(selecteddate==null ? 'No Date selected': DateFormat('dd/MM/yyyy').format(selecteddate!),style:Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),),
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
                  height: 70,
                  decoration: BoxDecoration(
                    color:Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text('Add  Expense',style:GoogleFonts.poppins(color: Theme.of(context).primaryColorLight,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ),
        ],
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

  const LedgerlyTextField({
    super.key,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.title,
    required this.maxlenth,
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
            child: Text(title,textAlign: TextAlign.start,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 13),),
          ),

          TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxlenth,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
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

