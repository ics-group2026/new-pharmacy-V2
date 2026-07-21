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

  /// Products belonging to a given category and/or brand.
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>>
  getProductsByFilter({
    int page = 1,
    int limit = 10,
    String? categoryId,
    String? brandId,
  });

  /// Free-text product search with optional price range and sort order.
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>>
  searchProducts({
    int page = 1,
    int limit = 10,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? sortOrder,
  });
}
