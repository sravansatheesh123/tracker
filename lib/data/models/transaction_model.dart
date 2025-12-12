import 'package:hive/hive.dart';
import '../../domain/entities/transaction_entity.dart';
@HiveType(typeId: 1)
class TransactionModel extends TransactionEntity {
  @HiveField(0)
  final String transactionId;

  @HiveField(1)
  final String transactionTitle;

  @HiveField(2)
  final double transactionAmount;

  @HiveField(3)
  final String transactionCategory;

  @HiveField(4)
  final DateTime transactionDate;

  @HiveField(5)
  final bool transactionIsIncome;

  TransactionModel({
    required this.transactionId,
    required this.transactionTitle,
    required this.transactionAmount,
    required this.transactionCategory,
    required this.transactionDate,
    required this.transactionIsIncome,
  }) : super(
    id: transactionId,
    title: transactionTitle,
    amount: transactionAmount,
    category: transactionCategory,
    date: transactionDate,
    isIncome: transactionIsIncome,
  );

  factory TransactionModel.fromEntity(TransactionEntity e) {
    return TransactionModel(
      transactionId: e.id,
      transactionTitle: e.title,
      transactionAmount: e.amount,
      transactionCategory: e.category,
      transactionDate: e.date,
      transactionIsIncome: e.isIncome,
    );
  }
}
