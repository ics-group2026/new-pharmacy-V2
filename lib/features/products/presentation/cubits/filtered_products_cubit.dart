import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/products_repo.dart';
import 'filtered_products_state.dart';

class FilteredProductsCubit extends Cubit<FilteredProductsState> {
  final ProductsRepo productsRepo;
  final String? categoryId;
  final String? brandId;
  static const _limit = 10;

  FilteredProductsCubit(this.productsRepo, {this.categoryId, this.brandId})
    : super(const FilteredProductsState());

  Future<void> getProducts() async {
    emit(
      state.copyWith(status: FilteredProductsStatus.loading, errorMessage: null),
    );
    final result = await productsRepo.getProductsByFilter(
      page: 1,
      limit: _limit,
      categoryId: categoryId,
      brandId: brandId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FilteredProductsStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: FilteredProductsStatus.loaded,
          products: page.items,
          page: 1,
          hasNext: page.hasNext,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext) return;

    emit(state.copyWith(status: FilteredProductsStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await productsRepo.getProductsByFilter(
      page: nextPage,
      limit: _limit,
      categoryId: categoryId,
      brandId: brandId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: FilteredProductsStatus.loaded,
          errorMessage: failure.errMessage,
        ),
      ),
      (page) => emit(
        state.copyWith(
          status: FilteredProductsStatus.loaded,
          products: [...state.products, ...page.items],
          page: nextPage,
          hasNext: page.hasNext,
        ),
      ),
    );
  }
}
