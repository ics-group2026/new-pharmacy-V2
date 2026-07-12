import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/update_profile_request_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getProfile();
  Future<Either<Failure, UserModel>> updateProfile(
    UpdateProfileRequestModel model,
  );
}
