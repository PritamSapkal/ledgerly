import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hive_ce/hive_ce.dart';

part 'expense_model.g.dart';

const uuid = Uuid();

@HiveType(typeId: 2)
enum Category {
  @HiveField(0) food,
  @HiveField(1) leisure,
  @HiveField(2) travel,
  @HiveField(3) movie,
  @HiveField(4) shopping,
  @HiveField(5) bills,
  @HiveField(6) groceries,
  @HiveField(7) health,
  @HiveField(8) education,
  @HiveField(9) other,
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

// Also, standard Dart naming convention suggests using CamelCase for class names (ExpenseModel)
@HiveType(typeId: 1) // Assign a unique type ID for the class
class expense_model extends HiveObject { // Extending HiveObject gives you easy .delete() options
  expense_model({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    String? id,
  }) : id = id ?? uuid.v4();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;

  String get formattedDate {
    return DateFormat.yMMMd().format(date);
  }
}