import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/products_repo.dart';
import 'filtered_products_state.dart';

class FilteredProductsCubit extends Cubit<FilteredProductsState> {
  final ProductsRepo productsRepo;
  final String? categoryId;
  final String? brandId;

  FilteredProductsCubit(this.productsRepo, {this.categoryId, this.brandId})
    : super(const FilteredProductsState());

  Future<void> getProducts() async {
    emit(
      state.copyWith(status: FilteredProductsStatus.loading, errorMessage: null),
    );
    final result = await productsRepo.getProductsByFilter(
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
      (products) => emit(
        state.copyWith(status: FilteredProductsStatus.loaded, products: products),
      ),
    );
  }
}
