import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_db.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDb localDb = TransactionLocalDb();

  @override
  List<TransactionEntity> getAllTransactions() {
    return localDb.getAll();
  }

  @override
  Future<void> addTransaction(TransactionEntity e) async {
    await localDb.add(TransactionModel.fromEntity(e));
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await localDb.delete(id);
  }

  // ADD THIS:
  @override
  Future<void> updateTransaction(TransactionEntity e) async {
    await localDb.update(TransactionModel.fromEntity(e));
  }
}
