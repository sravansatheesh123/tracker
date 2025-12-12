import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionLocalDb {
  final box = Hive.box<TransactionModel>('transactions');

  List<TransactionModel> getAll() => box.values.toList();

  Future<void> add(TransactionModel model) async {
    await box.put(model.transactionId, model);
  }

  Future<void> delete(String id) async {
    await box.delete(id);
  }

  // ADD THIS:
  Future<void> update(TransactionModel model) async {
    await box.put(model.transactionId, model);
  }
}
