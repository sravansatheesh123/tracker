import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/transaction_usecases.dart';
import '../../data/repositories/transaction_repository_impl.dart';

class TransactionProvider extends ChangeNotifier {
  final usecases = TransactionUsecases(TransactionRepositoryImpl());

  List<TransactionEntity> transactions = [];

  TransactionProvider() {
    load();
  }

  void load() {
    transactions = usecases.getAll();
    notifyListeners();
  }

  Future<void> addTransaction(String title, double amount, String category, bool income) async {
    final entity = TransactionEntity(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      category: category,
      date: DateTime.now(),
      isIncome: income,
    );
    await usecases.add(entity);
    load();
  }

  Future<void> deleteTransaction(String id) async {
    await usecases.delete(id);
    load();
  }

  double get balance {
    double income = transactions.where((e) => e.isIncome).fold(0, (s, e) => s + e.amount);
    double expense = transactions.where((e) => !e.isIncome).fold(0, (s, e) => s + e.amount);
    return income - expense;
  }
}
