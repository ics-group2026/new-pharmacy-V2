import '../../data/models/product_details_model.dart';

enum ProductDetailsStatus { initial, loading, loaded, error }

class ProductDetailsState {
  final ProductDetailsStatus status;
  final ProductDetailsModel? product;
  final String? errorMessage;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.errorMessage,
  });

  bool get isLoading => status == ProductDetailsStatus.loading;

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    ProductDetailsModel? product,
    String? errorMessage,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      product: product ?? this.product,
      errorMessage: errorMessage,
    );
  }
}
