import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../data/models/loyalty_transaction_model.dart';
import '../../data/models/wallet_transaction_types.dart';

class LoyaltyTransactionTile extends StatelessWidget {
  const LoyaltyTransactionTile({super.key, required this.transaction});

  final LoyaltyTransactionModel transaction;

  /// Falls back to the raw server value so an unrecognised type still renders.
  String _typeLabel() {
    switch (transaction.type) {
      case LoyaltyTransactionTypes.orderEarn:
        return AppTranslations.t('wallet.type.order_earn');
      case LoyaltyTransactionTypes.conversion:
        return AppTranslations.t('wallet.type.conversion');
      default:
        return transaction.type ?? '';
    }
  }

  IconData _icon() {
    switch (transaction.type) {
      case LoyaltyTransactionTypes.orderEarn:
        return Icons.stars_rounded;
      case LoyaltyTransactionTypes.conversion:
        return Icons.swap_horiz_rounded;
      default:
        return Icons.loyalty_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final createdAt = transaction.createdAt;

    final points = transaction.points ?? 0;
    final isCredit = transaction.isCredit;
    final accent = isCredit ? AppColors.success : AppColors.error;
    // points is already signed, so only the positive case needs a prefix.
    final sign = isCredit ? '+' : '';

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
            AppTranslations.t(
              'wallet.points_value',
              namedArgs: {'points': '$sign$points'},
            ),
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
