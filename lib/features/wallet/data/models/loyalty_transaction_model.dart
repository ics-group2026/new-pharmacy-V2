import '../../../../core/utils/converter.dart';

class LoyaltyTransactionModel {
  final String? id;
  final String? walletId;
  final int? points;
  final String? type;
  final String? referenceId;
  final DateTime? createdAt;

  const LoyaltyTransactionModel({
    this.id,
    this.walletId,
    this.points,
    this.type,
    this.referenceId,
    this.createdAt,
  });

  /// Unlike money transactions, [points] is already signed (`30`, `-200`).
  bool get isCredit => (points ?? 0) >= 0;

  factory LoyaltyTransactionModel.fromJson(Map<String, dynamic> json) =>
      LoyaltyTransactionModel(
        id: json['id'] as String?,
        walletId: json['walletId'] as String?,
        points: Converter.toIntOrNull(json['points']),
        type: json['type'] as String?,
        referenceId: json['referenceId'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'] as String)
            : null,
      );
}
