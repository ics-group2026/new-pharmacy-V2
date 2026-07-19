import '../../../../core/utils/converter.dart';
import 'wallet_transaction_types.dart';

class WalletTransactionModel {
  final String? id;
  final String? walletId;
  final double? amount;
  final String? type;
  final String? referenceId;
  final String? notes;
  final DateTime? createdAt;

  const WalletTransactionModel({
    this.id,
    this.walletId,
    this.amount,
    this.type,
    this.referenceId,
    this.notes,
    this.createdAt,
  });

  bool get isCredit =>
      type == WalletTransactionTypes.deposit ||
      type == WalletTransactionTypes.refund;

  bool get isDebit => type == WalletTransactionTypes.payment;

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      WalletTransactionModel(
        id: json['id'] as String?,
        walletId: json['walletId'] as String?,
        amount: Converter.toDoubleOrNull(json['amount']),
        type: json['type'] as String?,
        referenceId: json['referenceId'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
      );
}
