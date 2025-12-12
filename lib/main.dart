import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tracker/presentation/screens/add_transaction_screen.dart';
import 'package:tracker/presentation/screens/budget_screen.dart';
import 'package:tracker/presentation/screens/edit_transaction_screen.dart';

import 'data/models/transaction_model.g.dart';
import 'domain/entities/transaction_entity.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/transaction_provider.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'core/theme.dart';
import 'data/models/transaction_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionModelAdapter());
  await Hive.openBox<TransactionModel>('transactions');

  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Personal Finance Tracker",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

            home: const DashboardScreen(),

            routes: {
              "/add-transaction": (_) => const AddTransactionScreen(),
              "/edit-transaction": (context) {
                final tx = ModalRoute.of(context)!.settings.arguments as TransactionEntity;
                return EditTransactionScreen(transaction: tx);
              },
            },

          );

        },
      ),
    );
  }
}
