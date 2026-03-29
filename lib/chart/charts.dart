import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ledgerly/Model/expense_model.dart';
import 'package:ledgerly/pages/Homepgae.dart';
import '../main.dart';
import 'Chart_bar.dart';
enum ExpenseFilter { today, week, month, calendar }
class Chart extends StatelessWidget {
   Chart({super.key, required this.expenses});

  final List<expense_model> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.movie),
      ExpenseBucket.forCategory(expenses, Category.shopping),
      ExpenseBucket.forCategory(expenses, Category.bills),
      ExpenseBucket.forCategory(expenses, Category.groceries),
      ExpenseBucket.forCategory(expenses, Category.health),
      ExpenseBucket.forCategory(expenses, Category.education),
      ExpenseBucket.forCategory(expenses, Category.other),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  double get totalExpenses{
    double sum=0;
    for( final expense in expenses){
      sum +=expense.amount;
    }
    return sum;
  }

  ExpenseFilter selectedFilter = ExpenseFilter.today; // Default selection


  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: gradients.containerGradient,
      ),
      child: Column(
        children: [
          Text(
            "Total Expense: ₹ ${totalExpenses.toStringAsFixed(1)}",
            style:GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).canvasColor),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color:Theme.of(context).iconTheme.color
                  ),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}