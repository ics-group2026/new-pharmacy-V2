import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>> getProducts({
    int page = 1,
    int limit = 10,
  });
}
