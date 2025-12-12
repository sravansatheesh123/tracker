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

    // MediaQuery shortcuts
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04;
    final titleSize = size.width * 0.06;
    final balanceSize = size.width * 0.07;

    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true, // Center text
        backgroundColor: Colors.lightBlue, // Light blue

        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/add-transaction"),
      ),

      body: Column(
        children: [
          // Current Balance Card
          Card(
            margin: EdgeInsets.all(padding),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  Text(
                    "Current Balance",
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    provider.balance.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: balanceSize,
                      fontWeight: FontWeight.bold,
                      color: provider.balance >= 0 ? Colors.green : Colors.red,
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
                fontSize: titleSize * 0.9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                return TransactionTile(provider.transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
