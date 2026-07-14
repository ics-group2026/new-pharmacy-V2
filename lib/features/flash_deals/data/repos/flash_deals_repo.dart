import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/flash_deal_model.dart';

abstract class FlashDealsRepo {
  Future<Either<Failure, List<FlashDealModel>>> getActiveFlashDeals();
}
