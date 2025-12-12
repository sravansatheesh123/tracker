import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String category = "Food";
  bool isIncome = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],

      appBar: AppBar(
        title: const Text("Add Transaction", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : const Color(0xFF0A1D37),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.black12,
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                ],
              ),

              child: Column(
                children: [
                  _buildInputField(
                    controller: titleController,
                    label: "Title",
                    hint: "Enter transaction title",
                    isDark: isDark,
                  ),
                  SizedBox(height: padding * 0.8),
                  _buildInputField(
                    controller: amountController,
                    label: "Amount",
                    hint: "Enter amount",
                    keyboardType: TextInputType.number,
                    isDark: isDark,
                  ),
                  SizedBox(height: padding * 0.8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black26,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: category,
                      isExpanded: true,
                      dropdownColor: isDark ? Colors.grey[850] : Colors.white,
                      underline: SizedBox(),
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: size.width * 0.04,
                      ),
                      items: ["Food", "Travel", "Bills", "Shopping"]
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => category = v!),
                    ),
                  ),

                  SizedBox(height: padding * 0.8),
                  SwitchListTile(
                    title: Text(
                      "Income?",
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    value: isIncome,
                    onChanged: (v) => setState(() => isIncome = v),
                  ),

                  SizedBox(height: padding * 1.2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isDark ? Colors.grey[800] : const Color(0xFF0A1D37),
                        padding: EdgeInsets.symmetric(vertical: padding * 0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (titleController.text.isEmpty ||
                            amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("All fields required!")),
                          );
                          return;
                        }

                        context.read<TransactionProvider>().addTransaction(
                          titleController.text,
                          double.parse(amountController.text),
                          category,
                          isIncome,
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isDark = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
        filled: true,
        fillColor: isDark ? Colors.grey[850] : Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : Colors.black26,
          ),
        ),
      ),
    );
  }
}
