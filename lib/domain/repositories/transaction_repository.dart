import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  List<TransactionEntity> getAllTransactions();
  Future<void> addTransaction(TransactionEntity e);
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(TransactionEntity e);
}
