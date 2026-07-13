import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/banner_model.dart';
import 'banners_repo.dart';

class BannersRepoImpl implements BannersRepo {
  final ApiService apiService;
  BannersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<BannerModel>>> getStorefrontBanners({
    String type = 'MAIN_BANNER',
    int limit = 10,
  }) async {
    try {
      final result = await apiService.get(
        EndPoints.storefrontBanners,
        queryParameters: {'type': type, 'limit': limit},
      );
      final items = result['data'] as List;
      final banners = items
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(banners);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
