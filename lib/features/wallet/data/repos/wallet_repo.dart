import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/loyalty_transaction_model.dart';
import '../models/wallet_model.dart';
import '../models/wallet_transaction_model.dart';

abstract class WalletRepo {
  Future<Either<Failure, WalletModel>> getWallet();

  Future<Either<Failure, List<WalletTransactionModel>>> getTransactions();

  Future<Either<Failure, List<LoyaltyTransactionModel>>> getLoyaltyTransactions();

  Future<Either<Failure, WalletModel>> addFunds({
    required double amount,
    String? notes,
  });

  Future<Either<Failure, WalletModel>> convertLoyaltyPoints();
}
