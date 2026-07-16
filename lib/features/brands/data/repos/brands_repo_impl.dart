import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/brand_model.dart';
import 'brands_repo.dart';

class BrandsRepoImpl implements BrandsRepo {
  final ApiService apiService;
  BrandsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<BrandModel>>> getBrands() async {
    try {
      final result = await apiService.get(
        EndPoints.brands,
        queryParameters: {'page': 1, 'limit': 10},
      );
      final data = result['data'] as Map<String, dynamic>;
      final items = (data['items'] as List)
          .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(items);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
