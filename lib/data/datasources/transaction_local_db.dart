import 'package:hive/hive.dart';
import '../models/transaction_model.dart';

class TransactionLocalDb {
  final box = Hive.box<TransactionModel>('transactions');

  List<TransactionModel> getAll() => box.values.toList();

  Future<void> add(TransactionModel model) async => await box.put(model.id, model);

  Future<void> delete(String id) async => await box.delete(id);
}
