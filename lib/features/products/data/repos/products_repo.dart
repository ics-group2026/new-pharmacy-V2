import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/product_details_model.dart';
import '../models/product_model.dart';

abstract class ProductsRepo {
  /// [collection] is a storefront catalog preset (see `ProductCollections`);
  /// null returns the full catalogue.
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>> getProducts({
    int page = 1,
    int limit = 10,
    String? collection,
  });

  Future<Either<Failure, ProductDetailsModel>> getProductById(String id);
}
