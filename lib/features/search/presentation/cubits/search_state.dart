import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

enum SearchStatus { initial, loading, loadingMore, loaded, error }

class SearchState {
  final SearchStatus status;
  final List<ProductModel> products;
  final int page;
  final bool hasNext;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.products = const [],
    this.page = 1,
    this.hasNext = false,
    this.errorMessage,
  });

  bool get isLoadingMore => status == SearchStatus.loadingMore;

  SearchState copyWith({
    SearchStatus? status,
    List<ProductModel>? products,
    int? page,
    bool? hasNext,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
    );
  }
}
