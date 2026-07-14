import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/flash_deal_model.dart';
import 'flash_deals_repo.dart';

class FlashDealsRepoImpl implements FlashDealsRepo {
  final ApiService apiService;
  FlashDealsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<FlashDealModel>>> getActiveFlashDeals() async {
    try {
      final result = await apiService.get(
        EndPoints.activeDeals,
        queryParameters: {'type': 'FLASH'},
      );
      final items = result['data'] as List;
      final flashDeals = items
          .map((e) => FlashDealModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(flashDeals);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
