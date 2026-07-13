import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/banners_repo.dart';
import 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  final BannersRepo bannersRepo;

  BannersCubit(this.bannersRepo) : super(const BannersState());

  Future<void> getStorefrontBanners({
    String type = 'MAIN_BANNER',
    int limit = 10,
  }) async {
    emit(state.copyWith(status: BannersStatus.loading, errorMessage: null));
    final result = await bannersRepo.getStorefrontBanners(
      type: type,
      limit: limit,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BannersStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (banners) => emit(
        state.copyWith(status: BannersStatus.loaded, banners: banners),
      ),
    );
  }
}
