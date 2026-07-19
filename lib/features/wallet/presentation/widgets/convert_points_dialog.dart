import 'package:flutter/material.dart';

import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/t_text.dart';
import '../cubits/wallet_cubit.dart';

/// Confirms converting the full loyalty balance — the endpoint converts all
/// points at once, so this is not a partial-amount flow.
class ConvertPointsDialog extends StatelessWidget {
  const ConvertPointsDialog({super.key, required this.points});

  final int points;

  static Future<void> show(
    BuildContext context, {
    required WalletCubit cubit,
    required int points,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => ConvertPointsDialog(points: points),
    );
    if (confirmed == true) cubit.convertPoints();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TText('wallet.convert_title'),
      content: Text(
        AppTranslations.t(
          'wallet.convert_message',
          namedArgs: {'points': '$points'},
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: TText('common.cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: TText('wallet.convert'),
        ),
      ],
    );
  }
}
