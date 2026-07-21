import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/core/services/prefs.dart';
import 'package:new_pharmacy_v2/features/products/data/repos/products_repo.dart';
import 'package:new_pharmacy_v2/features/search/data/models/search_filters.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductsRepo productsRepo;
  static const _limit = 10;
  static const _debounceDuration = Duration(milliseconds: 400);
  static const _recentSearchesKey = 'recent_searches';
  static const _maxRecentSearches = 8;

  Timer? _debounce;

  SearchCubit(this.productsRepo) : super(const SearchState()) {
    emit(state.copyWith(recentSearches: Prefs.getStringList(_recentSearchesKey)));
  }

  /// Debounces user input, then searches once typing settles. An empty query
  /// clears results and falls back to the recent/popular searches view.
  void onQueryChanged(String query) {
    _debounce?.cancel();
    if (query.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, query: '', products: const []));
      return;
    }
    emit(state.copyWith(query: query));
    _debounce = Timer(_debounceDuration, () => _search(query));
  }

  /// Immediate search, bypassing debounce — used when the user taps a
  /// recent/popular search chip, or retries after an error.
  Future<void> submitSearch(String query) async {
    _debounce?.cancel();
    emit(state.copyWith(query: query));
    await _search(query);
  }

  /// Applying filters always re-queries, even with an empty search term, so
  /// the user can browse by category/brand/price alone.
  Future<void> applyFilters(SearchFilters filters) async {
    emit(state.copyWith(filters: filters));
    await _search(state.query);
  }

  Future<void> _search(String query) async {
    emit(state.copyWith(status: SearchStatus.loading, errorMessage: null));
    final result = await productsRepo.searchProducts(
      page: 1,
      limit: _limit,
      search: query,
      categoryId: state.filters.categoryId,
      brandId: state.filters.brandId,
      minPrice: state.filters.minPrice,
      maxPrice: state.filters.maxPrice,
      sortOrder: state.filters.apiSortOrder,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: SearchStatus.error, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: SearchStatus.loaded,
          products: page.items,
          page: 1,
          hasNext: page.hasNext,
        ),
      ),
    );
    if (query.isNotEmpty) await _rememberSearch(query);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext) return;

    emit(state.copyWith(status: SearchStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await productsRepo.searchProducts(
      page: nextPage,
      limit: _limit,
      search: state.query,
      categoryId: state.filters.categoryId,
      brandId: state.filters.brandId,
      minPrice: state.filters.minPrice,
      maxPrice: state.filters.maxPrice,
      sortOrder: state.filters.apiSortOrder,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: SearchStatus.loaded, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: SearchStatus.loaded,
          products: [...state.products, ...page.items],
          page: nextPage,
          hasNext: page.hasNext,
        ),
      ),
    );
  }

  Future<void> _rememberSearch(String query) async {
    final updated = [query, ...state.recentSearches.where((q) => q != query)]
        .take(_maxRecentSearches)
        .toList();
    emit(state.copyWith(recentSearches: updated));
    await Prefs.setStringList(_recentSearchesKey, updated);
  }

  Future<void> clearRecentSearches() async {
    emit(state.copyWith(recentSearches: const []));
    await Prefs.setStringList(_recentSearchesKey, const []);
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
