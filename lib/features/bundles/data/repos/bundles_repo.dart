import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/bundle_model.dart';

abstract class BundlesRepo {
  Future<Either<Failure, List<BundleModel>>> getActiveBundles();
}
