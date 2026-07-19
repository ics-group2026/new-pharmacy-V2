import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/loyalty_transaction_model.dart';
import '../../data/models/wallet_model.dart';
import '../../data/models/wallet_transaction_model.dart';
import '../../data/repos/wallet_repo.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletRepo walletRepo;

  WalletCubit(this.walletRepo) : super(const WalletState());

  Future<void> load() async {
    emit(state.copyWith(status: WalletStatus.loading, errorMessage: null));

    // Fire all three concurrently, then await each so the types stay intact.
    final walletFuture = walletRepo.getWallet();
    final transactionsFuture = walletRepo.getTransactions();
    final loyaltyFuture = walletRepo.getLoyaltyTransactions();

    final walletResult = await walletFuture;
    final transactionsResult = await transactionsFuture;
    final loyaltyResult = await loyaltyFuture;

    // The wallet record is the primary payload — only it can fail the screen.
    // A failing history degrades to an empty list so the balance still shows.
    final transactions = transactionsResult.getOrElse(
      () => const <WalletTransactionModel>[],
    );
    final loyaltyTransactions = loyaltyResult.getOrElse(
      () => const <LoyaltyTransactionModel>[],
    );

    walletResult.fold(
      (failure) => emit(
        state.copyWith(
          status: WalletStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (wallet) => emit(
        state.copyWith(
          status: WalletStatus.loaded,
          wallet: wallet,
          transactions: transactions,
          loyaltyTransactions: loyaltyTransactions,
        ),
      ),
    );
  }

  Future<void> addFunds({required double amount, String? notes}) async {
    await _runAction(
      WalletAction.addFunds,
      () => walletRepo.addFunds(amount: amount, notes: notes),
    );
  }

  Future<void> convertPoints() async {
    await _runAction(
      WalletAction.convertPoints,
      () => walletRepo.convertLoyaltyPoints(),
    );
  }

  /// Both actions return the updated wallet, so the balance is applied straight
  /// from the response; only the histories need re-fetching afterwards.
  Future<void> _runAction(
    WalletAction action,
    Future<Either<Failure, WalletModel>> Function() request,
  ) async {
    if (state.isSubmitting) return;
    emit(
      state.copyWith(
        action: action,
        actionStatus: WalletActionStatus.submitting,
      ),
    );

    final result = await request();

    final failure = result.fold<Failure?>((f) => f, (_) => null);
    if (failure != null) {
      emit(
        state.copyWith(
          actionStatus: WalletActionStatus.error,
          actionErrorMessage: failure.errMessage,
        ),
      );
      return;
    }

    final wallet = result.getOrElse(() => state.wallet ?? const WalletModel());
    emit(
      state.copyWith(wallet: wallet, actionStatus: WalletActionStatus.success),
    );
    await _refreshHistories();
  }

  Future<void> _refreshHistories() async {
    final transactionsFuture = walletRepo.getTransactions();
    final loyaltyFuture = walletRepo.getLoyaltyTransactions();

    final transactions = (await transactionsFuture).getOrElse(
      () => state.transactions,
    );
    final loyaltyTransactions = (await loyaltyFuture).getOrElse(
      () => state.loyaltyTransactions,
    );

    emit(
      state.copyWith(
        transactions: transactions,
        loyaltyTransactions: loyaltyTransactions,
        actionStatus: WalletActionStatus.idle,
        action: WalletAction.none,
      ),
    );
  }
}
