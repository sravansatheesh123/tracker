import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionTile(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
        color: transaction.isIncome ? Colors.green : Colors.red,
      ),
      title: Text(transaction.title),
      subtitle: Text(transaction.category),
      trailing: Text(
        "${transaction.isIncome ? "+" : "-"} ₹${transaction.amount}",
        style: TextStyle(
          color: transaction.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
