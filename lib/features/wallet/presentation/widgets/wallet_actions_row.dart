import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/t_text.dart';
import '../cubits/wallet_cubit.dart';
import 'add_funds_sheet.dart';
import 'convert_points_dialog.dart';

class WalletActionsRow extends StatelessWidget {
  const WalletActionsRow({
    super.key,
    required this.loyaltyPoints,
    required this.isSubmitting,
  });

  final int loyaltyPoints;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    // The sheet/dialog are pushed on the root Navigator, outside this subtree,
    // so the cubit has to be handed over explicitly.
    final cubit = context.read<WalletCubit>();
    final canConvert = loyaltyPoints > 0 && !isSubmitting;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: isSubmitting
                  ? null
                  : () => AddFundsSheet.show(context, cubit: cubit),
              icon: Icon(Icons.add_rounded, size: 18.r),
              label: TText('wallet.add_funds'),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: OutlinedButton.icon(
              onPressed: canConvert
                  ? () => ConvertPointsDialog.show(
                      context,
                      cubit: cubit,
                      points: loyaltyPoints,
                    )
                  : null,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Icons.swap_horiz_rounded, size: 18.r),
              label: TText('wallet.convert_points'),
            ),
          ),
        ),
      ],
    );
  }
}
