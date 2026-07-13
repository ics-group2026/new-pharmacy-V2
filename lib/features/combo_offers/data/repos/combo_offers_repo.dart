import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/combo_offer_model.dart';

abstract class ComboOffersRepo {
  Future<Either<Failure, List<ComboOfferModel>>> getActiveComboOffers();
}
