import 'package:hive_ce/hive.dart';
import 'package:ledgerly/Model/expense_model.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(expensemodelAdapter());
    registerAdapter(CategoryAdapter());
  }
}
