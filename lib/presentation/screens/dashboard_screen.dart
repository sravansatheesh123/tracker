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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.pushNamed(context, "/add-transaction"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              title: const Text("Current Balance"),
              subtitle: Text(provider.balance.toStringAsFixed(2)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Recent Transactions"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (c, i) {
                return TransactionTile(provider.transactions[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
