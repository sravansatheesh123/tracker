import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/transaction_entity.dart';

class ExpensePieChart extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const ExpensePieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final expenseTx = transactions.where((t) => !t.isIncome).toList();

    Map<String, double> data = {};
    for (var tx in expenseTx) {
      data[tx.category] = (data[tx.category] ?? 0) + tx.amount;
    }

    if (data.isEmpty) {
      return const Center(child: Text("No expenses yet"));
    }

    final Map<String, Color> categoryColors = {
      "Food": Colors.orange,
      "Travel": Colors.blue,
      "Bills": Colors.red,
      "Shopping": Colors.yellow,
      "Others": Colors.green,
    };

    return Card(
      elevation: isDark ? 0 : 4,
      color: isDark ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.015,
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: SizedBox(
          height: size.height * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.entries.map((entry) {
                    final color = categoryColors[entry.key] ?? Colors.teal;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.004),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.03,
                            height: size.width * 0.03,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                            ),
                          ),
                          SizedBox(width: size.width * 0.02),
                          Expanded(
                            child: Text(
                              "${entry.key} (₹${entry.value.toInt()})",
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                width: size.width * 0.35,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 35,
                    startDegreeOffset: 270,
                    sections: data.entries.map((entry) {
                      final color = categoryColors[entry.key] ?? Colors.teal;

                      return PieChartSectionData(
                        color: color,
                        value: entry.value,
                        radius: 45,
                        title: "",
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
