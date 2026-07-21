import '../../data/models/product_model.dart';

enum FilteredProductsStatus { initial, loading, loaded, error }

class FilteredProductsState {
  final FilteredProductsStatus status;
  final List<ProductModel> products;
  final String? errorMessage;

  const FilteredProductsState({
    this.status = FilteredProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
  });

  FilteredProductsState copyWith({
    FilteredProductsStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return FilteredProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage,
    );
  }
}
