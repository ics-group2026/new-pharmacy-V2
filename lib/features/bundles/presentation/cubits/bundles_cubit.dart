import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/bundles_repo.dart';
import 'bundles_state.dart';

class BundlesCubit extends Cubit<BundlesState> {
  final BundlesRepo bundlesRepo;

  BundlesCubit(this.bundlesRepo) : super(const BundlesState());

  Future<void> getActiveBundles() async {
    emit(state.copyWith(status: BundlesStatus.loading, errorMessage: null));
    final result = await bundlesRepo.getActiveBundles();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BundlesStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (bundles) =>
          emit(state.copyWith(status: BundlesStatus.loaded, bundles: bundles)),
    );
  }
}
