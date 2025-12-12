import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final Map<String, double> budgets = {
    "Food": 0,
    "Travel": 0,
    "Bills": 0,
    "Shopping": 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Budgets")),
      body: ListView(
        children: budgets.keys.map((category) {
          return ListTile(
            title: Text(category),
            subtitle: Text("Budget: ₹${budgets[category]!.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                double? newBudget = await showDialog(
                  context: context,
                  builder: (context) => BudgetEditDialog(
                    category: category,
                    currentBudget: budgets[category]!,
                  ),
                );

                if (newBudget != null) {
                  setState(() {
                    budgets[category] = newBudget;
                  });
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BudgetEditDialog extends StatefulWidget {
  final String category;
  final double currentBudget;

  const BudgetEditDialog({
    super.key,
    required this.category,
    required this.currentBudget,
  });

  @override
  State<BudgetEditDialog> createState() => _BudgetEditDialogState();
}

class _BudgetEditDialogState extends State<BudgetEditDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller =
        TextEditingController(text: widget.currentBudget.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Set budget for ${widget.category}"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, double.parse(controller.text));
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
