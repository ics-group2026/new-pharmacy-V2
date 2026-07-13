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

  
}
