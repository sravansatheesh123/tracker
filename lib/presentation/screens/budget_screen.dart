import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../providers/transaction_provider.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgetProvider = context.watch<BudgetProvider>();
    final txProvider = context.watch<TransactionProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;
    final titleFont = size.width * 0.05;
    final subtitleFont = size.width * 0.04;
    final indicatorSize = size.width * 0.03;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],

      appBar: AppBar(
        title: Text(
          "Budgets",
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDark ? Colors.grey[900] : const Color(0xFF0A1D37),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: EdgeInsets.all(padding),
        children: budgetProvider.budgets.keys.map((category) {
          final spent = budgetProvider.spentForCategory(category, txProvider.transactions);
          final limit = budgetProvider.budgets[category]!;
          final color = budgetProvider.usageColor(category, txProvider.transactions);

          return Container(
            margin: EdgeInsets.only(bottom: padding),
            padding: EdgeInsets.symmetric(vertical: padding * 0.8, horizontal: padding),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black12,
              ),
              boxShadow: [
                if (!isDark)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
              ],
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    SizedBox(height: padding * 0.3),
                    Text(
                      "Spent: ₹$spent / Budget: ₹$limit",
                      style: TextStyle(
                        fontSize: subtitleFont,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: indicatorSize,
                      backgroundColor: color,
                    ),
                    SizedBox(width: padding),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isDark ? Colors.grey[800] : const Color(0xFF0A1D37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: padding * 0.5,
                          horizontal: padding,
                        ),
                      ),
                      onPressed: () => _editBudget(context, category, limit, size),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleFont,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  void _editBudget(BuildContext context, String category, double currentBudget, Size size) {
    final controller = TextEditingController(text: currentBudget.toString());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        title: Text(
          "Set Budget for $category",
          style: TextStyle(
            fontSize: size.width * 0.05,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),

        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            labelText: "Budget Amount",
            labelStyle: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            filled: true,
            fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text) ?? 0;
              context.read<BudgetProvider>().setBudget(category, value);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isDark ? Colors.grey[800] : const Color(0xFF0A1D37),
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
