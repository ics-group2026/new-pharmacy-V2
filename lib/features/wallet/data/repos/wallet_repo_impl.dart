import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/loyalty_transaction_model.dart';
import '../models/wallet_model.dart';
import '../models/wallet_transaction_model.dart';
import 'wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final ApiService apiService;
  WalletRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, WalletModel>> getWallet() async {
    try {
      final result = await apiService.get(EndPoints.wallet);
      final data = result['data'] as Map<String, dynamic>;
      return Right(WalletModel.fromJson(data));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransactionModel>>> getTransactions() async {
    try {
      final result = await apiService.get(EndPoints.walletTransactions);
      final items = result['data'] as List;
      return Right(
        items
            .map((e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, List<LoyaltyTransactionModel>>>
  getLoyaltyTransactions() async {
    try {
      final result = await apiService.get(EndPoints.walletLoyaltyTransactions);
      final items = result['data'] as List;
      return Right(
        items
            .map(
              (e) => LoyaltyTransactionModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> addFunds({
    required double amount,
    String? notes,
  }) async {
    try {
      final result = await apiService.post(
        EndPoints.walletAddFunds,
        data: {'amount': amount, 'notes': ?notes},
      );
      final data = result['data'] as Map<String, dynamic>;
      return Right(WalletModel.fromJson(data));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> convertLoyaltyPoints() async {
    try {
      // The endpoint takes no body.
      final result = await apiService.post(
        EndPoints.loyaltyPointsConvert,
        data: const {},
      );
      final data = result['data'] as Map<String, dynamic>;
      return Right(WalletModel.fromJson(data));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
