import '../../data/models/flash_deal_model.dart';

enum FlashDealsStatus { initial, loading, loaded, error }

class FlashDealsState {
  final FlashDealsStatus status;
  final List<FlashDealModel> flashDeals;
  final String? errorMessage;

  const FlashDealsState({
    this.status = FlashDealsStatus.initial,
    this.flashDeals = const [],
    this.errorMessage,
  });

  bool get isLoading => status == FlashDealsStatus.loading;

  FlashDealsState copyWith({
    FlashDealsStatus? status,
    List<FlashDealModel>? flashDeals,
    String? errorMessage,
  }) {
    return FlashDealsState(
      status: status ?? this.status,
      flashDeals: flashDeals ?? this.flashDeals,
      errorMessage: errorMessage,
    );
  }
}
