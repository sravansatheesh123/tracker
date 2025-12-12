import 'package:hive/hive.dart';
import 'transaction_model.dart';

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 1;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }

    return TransactionModel(
      transactionId: fields[0] as String,
      transactionTitle: fields[1] as String,
      transactionAmount: fields[2] as double,
      transactionCategory: fields[3] as String,
      transactionDate: fields[4] as DateTime,
      transactionIsIncome: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.transactionId)
      ..writeByte(1)
      ..write(obj.transactionTitle)
      ..writeByte(2)
      ..write(obj.transactionAmount)
      ..writeByte(3)
      ..write(obj.transactionCategory)
      ..writeByte(4)
      ..write(obj.transactionDate)
      ..writeByte(5)
      ..write(obj.transactionIsIncome);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TransactionModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
