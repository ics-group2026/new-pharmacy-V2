import '../../data/models/banner_model.dart';

enum BannersStatus { initial, loading, loaded, error }

class BannersState {
  final BannersStatus status;
  final List<BannerModel> banners;
  final String? errorMessage;

  const BannersState({
    this.status = BannersStatus.initial,
    this.banners = const [],
    this.errorMessage,
  });

  bool get isLoading => status == BannersStatus.loading;

  BannersState copyWith({
    BannersStatus? status,
    List<BannerModel>? banners,
    String? errorMessage,
  }) {
    return BannersState(
      status: status ?? this.status,
      banners: banners ?? this.banners,
      errorMessage: errorMessage,
    );
  }
}
