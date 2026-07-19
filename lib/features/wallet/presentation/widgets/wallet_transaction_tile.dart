import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../data/models/wallet_transaction_model.dart';
import '../../data/models/wallet_transaction_types.dart';

class WalletTransactionTile extends StatelessWidget {
  const WalletTransactionTile({super.key, required this.transaction});

  final WalletTransactionModel transaction;

  /// Falls back to the raw server value so an unrecognised type still renders.
  String _typeLabel() {
    switch (transaction.type) {
      case WalletTransactionTypes.deposit:
        return AppTranslations.t('wallet.type.deposit');
      case WalletTransactionTypes.payment:
        return AppTranslations.t('wallet.type.payment');
      case WalletTransactionTypes.refund:
        return AppTranslations.t('wallet.type.refund');
      default:
        return transaction.type ?? '';
    }
  }

  IconData _icon() {
    switch (transaction.type) {
      case WalletTransactionTypes.deposit:
        return Icons.add_card_rounded;
      case WalletTransactionTypes.payment:
        return Icons.shopping_bag_outlined;
      case WalletTransactionTypes.refund:
        return Icons.undo_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');
    final createdAt = transaction.createdAt;
    final notes = transaction.notes;

    final isCredit = transaction.isCredit;
    final isDebit = transaction.isDebit;
    // Unknown types get neutral styling and no +/- sign.
    final accent = isCredit
        ? AppColors.success
        : isDebit
        ? AppColors.error
        : colorScheme.onSurfaceVariant;
    final sign = isCredit
        ? '+'
        : isDebit
        ? '-'
        : '';

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(_icon(), color: accent, size: 20.r),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                if (notes != null && notes.isNotEmpty) ...[
                  4.verticalSpace,
                  Text(
                    notes,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (createdAt != null) ...[
                  6.verticalSpace,
                  Text(
                    DateFormat(
                      'MMM d, hh:mm a',
                      context.locale.toString(),
                    ).format(createdAt),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ],
            ),
          ),
          8.horizontalSpace,
          Text(
            '$sign${(transaction.amount ?? 0).toStringAsFixed(0)} $currency',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}
