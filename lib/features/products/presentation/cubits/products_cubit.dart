import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/products_repo.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepo productsRepo;
  static const _limit = 10;

  /// Storefront preset to request (see `ProductCollections`); null loads the
  /// full catalogue. Mutable so a filter UI can switch presets in place.
  String? collection;

  ProductsCubit(this.productsRepo, {this.collection})
    : super(const ProductsState());

  /// Switches the requested preset and reloads. No-op when unchanged.
  Future<void> changeCollection(String? value) async {
    if (collection == value) return;
    collection = value;
    await getProducts();
  }

  Future<void> getProducts() async {
    emit(state.copyWith(status: ProductsStatus.loading, errorMessage: null));
    final result = await productsRepo.getProducts(
      page: 1,
      limit: _limit,
      collection: collection,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: ProductsStatus.error, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: ProductsStatus.loaded,
          products: page.items,
          page: 1,
          hasNext: page.hasNext,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNext) return;

    emit(state.copyWith(status: ProductsStatus.loadingMore));
    final nextPage = state.page + 1;
    final result = await productsRepo.getProducts(
      page: nextPage,
      limit: _limit,
      collection: collection,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: ProductsStatus.loaded, errorMessage: failure.errMessage),
      ),
      (page) => emit(
        state.copyWith(
          status: ProductsStatus.loaded,
          products: [...state.products, ...page.items],
          page: nextPage,
          hasNext: page.hasNext,
        ),
      ),
    );
  }
}
