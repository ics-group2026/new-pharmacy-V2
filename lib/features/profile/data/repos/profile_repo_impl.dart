import 'package:dartz/dartz.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/update_profile_request_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService apiService;
  ProfileRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final result = await apiService.get(EndPoints.me);
      final user = UserModel.fromJson(result['data'] as Map<String, dynamic>);
      return Right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(
    UpdateProfileRequestModel model,
  ) async {
    try {
      final result = await apiService.patch(
        EndPoints.updateMe,
        data: model.toJson(),
      );
      final user = UserModel.fromJson(result['data'] as Map<String, dynamic>);
      return Right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }
}
