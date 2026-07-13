import '../../data/models/combo_offer_model.dart';

enum ComboOffersStatus { initial, loading, loaded, error }

class ComboOffersState {
  final ComboOffersStatus status;
  final List<ComboOfferModel> comboOffers;
  final String? errorMessage;

  const ComboOffersState({
    this.status = ComboOffersStatus.initial,
    this.comboOffers = const [],
    this.errorMessage,
  });

  bool get isLoading => status == ComboOffersStatus.loading;

  ComboOffersState copyWith({
    ComboOffersStatus? status,
    List<ComboOfferModel>? comboOffers,
    String? errorMessage,
  }) {
    return ComboOffersState(
      status: status ?? this.status,
      comboOffers: comboOffers ?? this.comboOffers,
      errorMessage: errorMessage,
    );
  }
}
