import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/utils/snack_bar_helper.dart';
import '../../../../core/widgets/animated_fade_slide.dart';
import '../../data/repos/wallet_repo.dart';
import '../cubits/wallet_cubit.dart';
import '../cubits/wallet_state.dart';
import '../widgets/loyalty_transactions_list.dart';
import '../widgets/wallet_actions_row.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_loading.dart';
import '../widgets/wallet_segmented_control.dart';
import '../widgets/wallet_transactions_list.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(getIt<WalletRepo>())..load(),
      child: const _WalletBody(),
    );
  }
}

class _WalletBody extends StatefulWidget {
  const _WalletBody();

  @override
  State<_WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<_WalletBody> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(AppTranslations.t('wallet.title'))),
      // Single place that reports action outcomes, so the sheet and dialog
      // don't each raise their own snackbar.
      body: BlocListener<WalletCubit, WalletState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == WalletActionStatus.success) {
            context.showSnackBar(
              AppTranslations.t(
                state.action == WalletAction.convertPoints
                    ? 'wallet.points_converted'
                    : 'wallet.funds_added',
              ),
            );
          } else if (state.actionStatus == WalletActionStatus.error) {
            context.showErrorSnackBar(
              state.actionErrorMessage ?? AppTranslations.t('common.no_data'),
            );
          }
        },
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
          if (state.isLoading) return const WalletLoading();

          if (state.status == WalletStatus.error) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorMessage ?? AppTranslations.t('common.no_data'),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    12.verticalSpace,
                    TextButton(
                      onPressed: () => context.read<WalletCubit>().load(),
                      child: Text(AppTranslations.t('common.retry')),
                    ),
                  ],
                ),
              ),
            );
          }

          final wallet = state.wallet;
          if (wallet == null) return const SizedBox.shrink();

          return RefreshIndicator(
            onRefresh: () => context.read<WalletCubit>().load(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedFadeSlide(
                    child: WalletBalanceCard(wallet: wallet),
                  ),
                  16.verticalSpace,
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 60),
                    child: WalletActionsRow(
                      loyaltyPoints: wallet.loyaltyPoints ?? 0,
                      isSubmitting: state.isSubmitting,
                    ),
                  ),
                  20.verticalSpace,
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 100),
                    child: WalletSegmentedControl(
                      selectedIndex: _selectedTab,
                      onSelected: (index) =>
                          setState(() => _selectedTab = index),
                    ),
                  ),
                  16.verticalSpace,
                  AnimatedFadeSlide(
                    // Re-runs the entrance animation when the tab changes.
                    key: ValueKey(_selectedTab),
                    delay: const Duration(milliseconds: 140),
                    child: _selectedTab == 0
                        ? WalletTransactionsList(
                            transactions: state.transactions,
                          )
                        : LoyaltyTransactionsList(
                            transactions: state.loyaltyTransactions,
                          ),
                  ),
                ],
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}
