import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionTile extends StatelessWidget {
  final TransactionEntity transaction;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.grey[900] : Colors.white,
      elevation: isDark ? 0 : 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(
          transaction.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: transaction.isIncome ? Colors.green : Colors.red,
        ),

        title: Text(
          transaction.title,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),

        subtitle: Text(
          transaction.category,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),

        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert,
              color: isDark ? Colors.white70 : Colors.black87),

          onSelected: (value) {
            if (value == "view") onView();
            if (value == "edit") onEdit();
            if (value == "delete") onDelete();
          },

          itemBuilder: (context) => [
            const PopupMenuItem(value: "view", child: Text("View")),
            const PopupMenuItem(value: "edit", child: Text("Edit")),
            const PopupMenuItem(
              value: "delete",
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),

        onTap: onView,
      ),
    );
  }
}
