import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/combo_offer_model.dart';
import 'combo_offers_repo.dart';

class ComboOffersRepoImpl implements ComboOffersRepo {
  final ApiService apiService;
  ComboOffersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<ComboOfferModel>>> getActiveComboOffers() async {
    try {
      final result = await apiService.get(EndPoints.activeComboOffers);
      final items = result['data'] as List;
      final comboOffers = items
          .map((e) => ComboOfferModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(comboOffers);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
