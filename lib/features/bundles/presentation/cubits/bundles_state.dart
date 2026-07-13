import '../../data/models/bundle_model.dart';

enum BundlesStatus { initial, loading, loaded, error }

class BundlesState {
  final BundlesStatus status;
  final List<BundleModel> bundles;
  final String? errorMessage;

  const BundlesState({
    this.status = BundlesStatus.initial,
    this.bundles = const [],
    this.errorMessage,
  });

  bool get isLoading => status == BundlesStatus.loading;

  BundlesState copyWith({
    BundlesStatus? status,
    List<BundleModel>? bundles,
    String? errorMessage,
  }) {
    return BundlesState(
      status: status ?? this.status,
      bundles: bundles ?? this.bundles,
      errorMessage: errorMessage,
    );
  }
}
