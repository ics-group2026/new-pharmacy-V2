import '../../../../core/utils/converter.dart';

class WalletModel {
  final String? id;
  final String? userId;
  final double? walletBalance;
  final int? loyaltyPoints;
  final String? referralCode;
  final String? referredById;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WalletModel({
    this.id,
    this.userId,
    this.walletBalance,
    this.loyaltyPoints,
    this.referralCode,
    this.referredById,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    // Balances can arrive as a decimal string from the DB column.
    walletBalance: Converter.toDoubleOrNull(json['walletBalance']),
    loyaltyPoints: Converter.toIntOrNull(json['loyaltyPoints']),
    referralCode: json['referralCode'] as String?,
    referredById: json['referredById'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'] as String)
        : null,
  );
}
