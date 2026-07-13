import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/category_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
