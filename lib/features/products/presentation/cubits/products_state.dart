import '../../data/models/product_model.dart';

enum ProductsStatus { initial, loading, loadingMore, loaded, error }

class ProductsState {
  final ProductsStatus status;
  final List<ProductModel> products;
  final int page;
  final bool hasNext;
  final String? errorMessage;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.page = 1,
    this.hasNext = false,
    this.errorMessage,
  });

  bool get isLoading => status == ProductsStatus.loading;
  bool get isLoadingMore => status == ProductsStatus.loadingMore;

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductModel>? products,
    int? page,
    bool? hasNext,
    String? errorMessage,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
    );
  }
}
