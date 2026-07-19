import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../data/models/wallet_transaction_model.dart';
import 'wallet_transaction_tile.dart';

class WalletTransactionsList extends StatelessWidget {
  const WalletTransactionsList({super.key, required this.transactions});

  final List<WalletTransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: const EmptyDataPlaceholder(messageKey: 'wallet.no_transactions'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      separatorBuilder: (_, _) => 12.verticalSpace,
      itemBuilder: (_, index) =>
          WalletTransactionTile(transaction: transactions[index]),
    );
  }
}
