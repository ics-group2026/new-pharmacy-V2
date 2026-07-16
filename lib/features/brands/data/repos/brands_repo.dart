import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/brand_model.dart';

abstract class BrandsRepo {
  Future<Either<Failure, List<BrandModel>>> getBrands();
}
