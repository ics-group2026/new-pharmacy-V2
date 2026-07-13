import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/bundle_model.dart';
import 'bundles_repo.dart';

class BundlesRepoImpl implements BundlesRepo {
  final ApiService apiService;
  BundlesRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<BundleModel>>> getActiveBundles() async {
    try {
      final result = await apiService.get(EndPoints.activeBundles);
      final items = result['data'] as List;
      final bundles = items
          .map((e) => BundleModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(bundles);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, BundleModel>> getActiveBundleById(String id) async {
    try {
      final result = await apiService.get(EndPoints.activeBundleById(id));
      final bundle = BundleModel.fromJson(
        result['data'] as Map<String, dynamic>,
      );
      return Right(bundle);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
