import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/banner_model.dart';

abstract class BannersRepo {
  Future<Either<Failure, List<BannerModel>>> getStorefrontBanners({
    String type,
    int limit,
  });
}
