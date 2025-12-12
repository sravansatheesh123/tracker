import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../data/models/budget_model.dart';
import '../../domain/entities/transaction_entity.dart';

class BudgetProvider extends ChangeNotifier {
  final _box = Hive.box<BudgetModel>('budgets');

  Map<String, double> budgets = {
    "Food": 0,
    "Travel": 0,
    "Bills": 0,
    "Shopping": 0,
  };

  BudgetProvider() {
    loadBudgets();
  }
  void loadBudgets() {
    for (var key in budgets.keys) {
      if (_box.containsKey(key)) {
        budgets[key] = _box.get(key)!.amount;
      }
    }
    notifyListeners();
  }
  Future<void> setBudget(String category, double amount) async {
    budgets[category] = amount;
    await _box.put(category, BudgetModel(category: category, amount: amount));
    notifyListeners();
  }
  double spentForCategory(String category, List<TransactionEntity> txList) {
    return txList
        .where((t) => t.category == category && !t.isIncome)
        .fold(0, (s, t) => s + t.amount);
  }

  double percentUsed(String category, List<TransactionEntity> txList) {
    final spent = spentForCategory(category, txList);
    final limit = budgets[category] ?? 0;

    if (limit == 0) return 0;
    return (spent / limit).clamp(0, 1);
  }

  Color usageColor(String category, List<TransactionEntity> txList) {
    final spent = spentForCategory(category, txList);
    final limit = budgets[category] ?? 0;

    if (limit == 0) return Colors.grey;

    final pct = spent / limit;

    if (pct >= 1) return Colors.red;
    if (pct >= 0.8) return Colors.orange;
    return Colors.green;
  }
}
