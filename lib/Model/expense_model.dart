import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category {
 food, leisure, travel, movie, shopping,
 bills, groceries, health, education, other
}

const categoryIcons = {
 Category.food: Icons.fastfood_rounded,
 Category.leisure: Icons.sports_esports_rounded,
 Category.travel: Icons.directions_bus_rounded,
 Category.movie: Icons.movie_creation_rounded,
 Category.shopping: Icons.shopping_bag_rounded,
 Category.bills: Icons.receipt_long_rounded,
 Category.groceries: Icons.local_grocery_store_rounded,
 Category.health: Icons.medical_services_rounded,
 Category.education: Icons.school_rounded,
 Category.other: Icons.miscellaneous_services_rounded,
};

class expense_model {
 expense_model({
  required this.title,
  required this.amount,
  required this.date,
  required this.category,
 }) : id = uuid.v4();

 final String id;
 final String title;
 final double amount;
 final DateTime date;
 final Category category;

 String get formattedDate {
  return DateFormat.yMMMd().format(date);
 }
}