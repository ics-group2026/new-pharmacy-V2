import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/category_model.dart';
import 'categories_repo.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final ApiService apiService;
  CategoriesRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final result = await apiService.get(EndPoints.categories);
      final items = result['data']['items'] as List;
      final categories = items
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(categories);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
