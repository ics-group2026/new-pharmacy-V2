import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/t_text.dart';
import '../../data/models/wallet_model.dart';
import 'wallet_referral_chip.dart';
import 'wallet_stat_tile.dart';

/// The wallet hero. Uses the app's single existing gradient (the Account
/// header's) so it reads as part of the same design language.
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key, required this.wallet});

  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = AppTranslations.t('flash_deals.currency');
    final balance = wallet.walletBalance ?? 0;
    final points = wallet.loyaltyPoints ?? 0;
    final referralCode = wallet.referralCode;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      // Clips the oversized watermark icon to the rounded corners.
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Faint watermark, clipped by the card's rounded corners.
          Positioned(
            top: -12.h,
            right: -8.w,
            child: Icon(
              Icons.account_balance_wallet_rounded,
              size: 96.r,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TText(
                'wallet.balance',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              6.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    balance.toStringAsFixed(0),
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  6.horizontalSpace,
                  Text(
                    currency,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Divider(color: Colors.white.withValues(alpha: 0.2), height: 1),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: WalletStatTile(
                      icon: Icons.stars_rounded,
                      labelKey: 'wallet.loyalty_points',
                      value: '$points',
                    ),
                  ),
                  if (referralCode != null && referralCode.isNotEmpty) ...[
                    12.horizontalSpace,
                    Flexible(child: WalletReferralChip(code: referralCode)),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
