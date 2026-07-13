import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/combo_offers_repo.dart';
import 'combo_offers_state.dart';

class ComboOffersCubit extends Cubit<ComboOffersState> {
  final ComboOffersRepo comboOffersRepo;

  ComboOffersCubit(this.comboOffersRepo) : super(const ComboOffersState());

  Future<void> getActiveComboOffers() async {
    emit(state.copyWith(status: ComboOffersStatus.loading, errorMessage: null));
    final result = await comboOffersRepo.getActiveComboOffers();
    result.fold(
      (failure) => emit(
        state.copyWith(status: ComboOffersStatus.error, errorMessage: failure.errMessage),
      ),
      (comboOffers) => emit(
        state.copyWith(status: ComboOffersStatus.loaded, comboOffers: comboOffers),
      ),
    );
  }
}
