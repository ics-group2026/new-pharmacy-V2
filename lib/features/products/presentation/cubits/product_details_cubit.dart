import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/products_repo.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductsRepo productsRepo;

  ProductDetailsCubit(this.productsRepo) : super(const ProductDetailsState());

  Future<void> getProductById(String id) async {
    emit(state.copyWith(status: ProductDetailsStatus.loading, errorMessage: null));
    final result = await productsRepo.getProductById(id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductDetailsStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (product) => emit(
        state.copyWith(status: ProductDetailsStatus.loaded, product: product),
      ),
    );
  }
}
