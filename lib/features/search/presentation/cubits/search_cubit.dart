import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/features/products/data/repos/products_repo.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductsRepo productsRepo;
  static const _limit = 10;
  static const _debounceDuration = Duration(milliseconds: 400);

  Timer? _debounce;
  String _query = '';

  SearchCubit(this.productsRepo) : super(const SearchState());

  /// Debounces user input, then searches once typing settles. An empty query
  /// clears results instead of hitting the API.
  void onQueryChanged(String query) {
    _debounce?.cancel();
    if (query.isEmpty) {
      _query = '';
      emit(const SearchState());
      return;
    }
    _debounce = Timer(_debounceDuration, () => _search(query));
  }

  Future<void> _search(String query) async {
    _query = query;
    emit(state.copyWith(status: SearchStatus.loading, errorMessage: null));
    final result = await productsRepo.searchProducts(
      page: 1,
      limit: _limit,
      search: query,
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
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext || _query.isEmpty) return;

    emit(state.copyWith(status: SearchStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await productsRepo.searchProducts(
      page: nextPage,
      limit: _limit,
      search: _query,
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

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
