import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/brands_repo.dart';
import 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final BrandsRepo brandsRepo;

  BrandsCubit(this.brandsRepo) : super(const BrandsState());

  Future<void> getBrands() async {
    emit(state.copyWith(status: BrandsStatus.loading, errorMessage: null));
    final result = await brandsRepo.getBrands();
    result.fold(
      (failure) => emit(
        state.copyWith(status: BrandsStatus.error, errorMessage: failure.errMessage),
      ),
      (brands) => emit(state.copyWith(status: BrandsStatus.loaded, brands: brands)),
    );
  }
}
