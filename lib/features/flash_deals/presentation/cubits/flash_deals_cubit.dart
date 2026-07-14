import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/flash_deals_repo.dart';
import 'flash_deals_state.dart';

class FlashDealsCubit extends Cubit<FlashDealsState> {
  final FlashDealsRepo flashDealsRepo;

  FlashDealsCubit(this.flashDealsRepo) : super(const FlashDealsState());

  Future<void> getActiveFlashDeals() async {
    emit(state.copyWith(status: FlashDealsStatus.loading, errorMessage: null));
    final result = await flashDealsRepo.getActiveFlashDeals();
    result.fold(
      (failure) => emit(
        state.copyWith(status: FlashDealsStatus.error, errorMessage: failure.errMessage),
      ),
      (flashDeals) => emit(
        state.copyWith(status: FlashDealsStatus.loaded, flashDeals: flashDeals),
      ),
    );
  }
}
