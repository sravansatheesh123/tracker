import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/transaction_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;
    final titleSize = size.width * 0.045;
    final balanceSize = size.width * 0.055;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[900] : Color(0xFF0A1D37),
        iconTheme: const IconThemeData(color: Colors.white),

        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, "/budget"),
          ),

          IconButton(
            icon: const Icon(Icons.brightness_6, color: Colors.white),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark ? Colors.grey[800] : Color(0xFF0A1D37),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, "/add-transaction"),
      ),

      body: Column(
        children: [
          Card(
            color: isDark ? Colors.grey[900] : Colors.white,
            margin: EdgeInsets.all(padding),
            elevation: isDark ? 0 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: padding * 0.7,
                horizontal: padding,
              ),
              child: Column(
                children: [
                  Text(
                    "Current Balance",
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    provider.balance.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: balanceSize,
                      fontWeight: FontWeight.bold,
                      color: provider.balance >= 0
                          ? Colors.green
                          : Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                final tx = provider.transactions[index];
                final isDark = Theme.of(context).brightness == Brightness.dark;

                return TransactionTile(
                  transaction: tx,

                  onView: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                        title: Text("Transaction Details",
                            style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title: ${tx.title}"),
                            Text("Amount: ₹${tx.amount}"),
                            Text("Category: ${tx.category}"),
                            Text("Type: ${tx.isIncome ? "Income" : "Expense"}"),
                            Text("Date: ${tx.date}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },

                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      "/edit-transaction",
                      arguments: tx,
                    );
                  },

                  onDelete: () {
                    provider.deleteTransaction(tx.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Deleted ${tx.title}")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
