import '../../data/models/brand_model.dart';

enum BrandsStatus { initial, loading, loaded, error }

class BrandsState {
  final BrandsStatus status;
  final List<BrandModel> brands;
  final String? errorMessage;

  const BrandsState({
    this.status = BrandsStatus.initial,
    this.brands = const [],
    this.errorMessage,
  });

  BrandsState copyWith({
    BrandsStatus? status,
    List<BrandModel>? brands,
    String? errorMessage,
  }) {
    return BrandsState(
      status: status ?? this.status,
      brands: brands ?? this.brands,
      errorMessage: errorMessage,
    );
  }
}
