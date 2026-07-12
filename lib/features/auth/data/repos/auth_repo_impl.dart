import 'package:dartz/dartz.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/prefs.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, UserModel>> login(LoginRequestModel model) async {
    try {
      final result = await apiService.post(EndPoints.login, data: model.toJson());
      final data = result['data'] as Map<String, dynamic>;
      saveToken(data['accessToken'] as String);
      saveRefreshToken(data['refreshToken'] as String);
      final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      return Right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(RegisterRequestModel model) async {
    try {
      final result = await apiService.post(
        EndPoints.customerRegister,
        data: model.toJson(),
      );
      final data = result['data'] as Map<String, dynamic>;
      saveToken(data['accessToken'] as String);
      saveRefreshToken(data['refreshToken'] as String);
      final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      return Right(user);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  void saveToken(String token) {
    Prefs.setString(kToken, token);
  }

  @override
  void saveRefreshToken(String refreshToken) {
    Prefs.setString(kRefreshToken, refreshToken);
  }
}
