import '../../data/models/loyalty_transaction_model.dart';
import '../../data/models/wallet_model.dart';
import '../../data/models/wallet_transaction_model.dart';

enum WalletStatus { initial, loading, loaded, error }

/// Tracks add-funds / convert-points separately from the page load, so an
/// in-flight action never replaces the screen with a full-page loader.
enum WalletActionStatus { idle, submitting, success, error }

/// Which action produced the current [WalletState.actionStatus].
enum WalletAction { none, addFunds, convertPoints }

class WalletState {
  final WalletStatus status;
  final WalletModel? wallet;
  final List<WalletTransactionModel> transactions;
  final List<LoyaltyTransactionModel> loyaltyTransactions;
  final String? errorMessage;
  final WalletActionStatus actionStatus;
  final WalletAction action;
  final String? actionErrorMessage;

  const WalletState({
    this.status = WalletStatus.initial,
    this.wallet,
    this.transactions = const [],
    this.loyaltyTransactions = const [],
    this.errorMessage,
    this.actionStatus = WalletActionStatus.idle,
    this.action = WalletAction.none,
    this.actionErrorMessage,
  });

  bool get isLoading =>
      status == WalletStatus.initial || status == WalletStatus.loading;

  bool get isSubmitting => actionStatus == WalletActionStatus.submitting;

  WalletState copyWith({
    WalletStatus? status,
    WalletModel? wallet,
    List<WalletTransactionModel>? transactions,
    List<LoyaltyTransactionModel>? loyaltyTransactions,
    String? errorMessage,
    WalletActionStatus? actionStatus,
    WalletAction? action,
    String? actionErrorMessage,
  }) {
    return WalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      loyaltyTransactions: loyaltyTransactions ?? this.loyaltyTransactions,
      errorMessage: errorMessage,
      actionStatus: actionStatus ?? this.actionStatus,
      action: action ?? this.action,
      actionErrorMessage: actionErrorMessage,
    );
  }
}
