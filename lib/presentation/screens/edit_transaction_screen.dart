import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/transaction_entity.dart';
import '../providers/transaction_provider.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionEntity transaction;

  const EditTransactionScreen({super.key, required this.transaction});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  late TextEditingController titleController;
  late TextEditingController amountController;
  late String category;
  late bool isIncome;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.transaction.title);
    amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    category = widget.transaction.category;
    isIncome = widget.transaction.isIncome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            DropdownButton<String>(
              value: category,
              items: ["Food", "Travel", "Bills", "Shopping"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => category = v!),
            ),
            SwitchListTile(
              title: const Text("Income?"),
              value: isIncome,
              onChanged: (v) => setState(() => isIncome = v),
            ),
            ElevatedButton(
              onPressed: () async {
                await context.read<TransactionProvider>().updateTransaction(
                  widget.transaction.id,
                  titleController.text,
                  double.parse(amountController.text),
                  category,
                  isIncome,
                );
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
