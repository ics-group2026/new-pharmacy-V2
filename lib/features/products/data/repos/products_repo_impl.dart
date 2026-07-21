import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/product_details_model.dart';
import '../models/product_model.dart';
import 'products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ApiService apiService;
  ProductsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>> getProducts({
    int page = 1,
    int limit = 10,
    String? collection,
  }) async {
    try {
      final result = await apiService.get(
        EndPoints.products,
        queryParameters: {'page': page, 'limit': limit, 'collection': ?collection},
      );
      final data = result['data'] as Map<String, dynamic>;
      final items = (data['items'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final meta = data['meta'] as Map<String, dynamic>?;
      final hasNext = meta?['hasNext'] as bool? ?? false;
      return Right((items: items, hasNext: hasNext));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductById(String id) async {
    try {
      final result = await apiService.get(EndPoints.productById(id));
      final data = result['data'] as Map<String, dynamic>;
      return Right(ProductDetailsModel.fromJson(data));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>>
  getProductsByFilter({
    int page = 1,
    int limit = 10,
    String? categoryId,
    String? brandId,
  }) async {
    try {
      final result = await apiService.get(
        EndPoints.products,
        queryParameters: {
          'page': page,
          'limit': limit,
          'categoryId': ?categoryId,
          'brandId': ?brandId,
        },
      );
      final data = result['data'] as Map<String, dynamic>;
      final items = (data['items'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final meta = data['meta'] as Map<String, dynamic>?;
      final hasNext = meta?['hasNext'] as bool? ?? false;
      return Right((items: items, hasNext: hasNext));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, ({List<ProductModel> items, bool hasNext})>>
  searchProducts({
    int page = 1,
    int limit = 10,
    String? search,
    double? minPrice,
    double? maxPrice,
    String? sortOrder,
  }) async {
    try {
      final result = await apiService.get(
        EndPoints.products,
        queryParameters: {
          'page': page,
          'limit': limit,
          'search': ?search,
          'minPrice': ?minPrice,
          'maxPrice': ?maxPrice,
          'sortOrder': ?sortOrder,
        },
      );
      final data = result['data'] as Map<String, dynamic>;
      final items = (data['items'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final meta = data['meta'] as Map<String, dynamic>?;
      final hasNext = meta?['hasNext'] as bool? ?? false;
      return Right((items: items, hasNext: hasNext));
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
