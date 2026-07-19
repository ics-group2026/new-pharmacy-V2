import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../../../core/utils/snack_bar_helper.dart';
import '../../../../core/widgets/t_text.dart';

/// Referral code with tap-to-copy. Sits on the brand gradient, hence the
/// white-on-translucent colours rather than theme tokens.
class WalletReferralChip extends StatelessWidget {
  const WalletReferralChip({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: code));
        if (!context.mounted) return;
        context.showSnackBar(AppTranslations.t('wallet.code_copied'));
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TText(
                  'wallet.referral_code',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                2.verticalSpace,
                Text(
                  code,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            8.horizontalSpace,
            Icon(Icons.copy_rounded, size: 16.r, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
