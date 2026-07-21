import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'package:new_pharmacy_v2/features/search/data/models/search_filters.dart';

enum SearchStatus { initial, loading, loadingMore, loaded, error }

class SearchState {
  final SearchStatus status;
  final String query;
  final List<ProductModel> products;
  final int page;
  final bool hasNext;
  final String? errorMessage;
  final SearchFilters filters;
  final List<String> recentSearches;

  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.products = const [],
    this.page = 1,
    this.hasNext = false,
    this.errorMessage,
    this.filters = const SearchFilters(),
    this.recentSearches = const [],
  });

  bool get isLoadingMore => status == SearchStatus.loadingMore;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<ProductModel>? products,
    int? page,
    bool? hasNext,
    String? errorMessage,
    SearchFilters? filters,
    List<String>? recentSearches,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      products: products ?? this.products,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
      filters: filters ?? this.filters,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}
