import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
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

  Future<void> addTransaction(
      String title, double amount, String category, bool income) async {

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

  Future<void> updateTransaction(
      String id,
      String title,
      double amount,
      String category,
      bool income) async {

    final updated = TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      category: category,
      date: DateTime.now(),
      isIncome: income,
    );

    await usecases.update(updated);
    load();
  }

  Future<void> deleteTransaction(String id) async {
    await usecases.delete(id);
    load();
  }

  List<TransactionEntity> get recentTransactions {
    return transactions.reversed.take(10).toList();
  }

  double get balance {
    double income = transactions
        .where((t) => t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);

    double expense = transactions
        .where((t) => !t.isIncome)
        .fold(0, (sum, t) => sum + t.amount);

    return income - expense;
  }

  Future<String> exportCSV() async {
    List<List<dynamic>> rows = [
      ["Title", "Amount", "Category", "Type", "Date"]
    ];

    for (var t in transactions) {
      rows.add([
        t.title,
        t.amount,
        t.category,
        t.isIncome ? "Income" : "Expense",
        t.date.toIso8601String(),
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/transactions.csv";

    final file = File(path);
    await file.writeAsString(csvData);

    await OpenFilex.open(path);

    return path;
  }
}
