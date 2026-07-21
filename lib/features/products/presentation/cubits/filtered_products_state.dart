import '../../data/models/product_model.dart';

enum FilteredProductsStatus { initial, loading, loadingMore, loaded, error }

class FilteredProductsState {
  final FilteredProductsStatus status;
  final List<ProductModel> products;
  final int page;
  final bool hasNext;
  final String? errorMessage;

  const FilteredProductsState({
    this.status = FilteredProductsStatus.initial,
    this.products = const [],
    this.page = 1,
    this.hasNext = false,
    this.errorMessage,
  });

  bool get isLoadingMore => status == FilteredProductsStatus.loadingMore;

  FilteredProductsState copyWith({
    FilteredProductsStatus? status,
    List<ProductModel>? products,
    int? page,
    bool? hasNext,
    String? errorMessage,
  }) {
    return FilteredProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
    );
  }
}
