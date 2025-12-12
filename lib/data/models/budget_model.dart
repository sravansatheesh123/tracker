import 'package:hive/hive.dart';
@HiveType(typeId: 2)
class BudgetModel extends HiveObject {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final double amount;

  BudgetModel({
    required this.category,
    required this.amount,
  });
}
