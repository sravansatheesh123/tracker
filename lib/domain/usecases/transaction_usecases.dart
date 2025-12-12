import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionUsecases {
  final TransactionRepository repository;

  TransactionUsecases(this.repository);

  List<TransactionEntity> getAll() => repository.getAllTransactions();

  Future<void> add(TransactionEntity entity) => repository.addTransaction(entity);

  Future<void> delete(String id) => repository.deleteTransaction(id);
}
