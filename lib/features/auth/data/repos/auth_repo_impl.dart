import 'package:dartz/dartz.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/prefs.dart';
import '../models/delete_account_request_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, void>> login(
    LoginRequestModel loginRuequestModel, {
    required bool rememberMe,
  }) async {
    try {
      final result = await apiService.post(
        EndPoints.login,
        data: loginRuequestModel.toJson(),
      );
      final data = result['data'] as Map<String, dynamic>;
      saveToken(data['accessToken'] as String);
      saveRefreshToken(data['refreshToken'] as String);
      Prefs.setBool(kRememberMe, rememberMe);
      return const Right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    try {
      final result = await apiService.post(
        EndPoints.customerRegister,
        data: registerRequestModel.toJson(),
      );
      final data = result['data'] as Map<String, dynamic>;
      saveToken(data['accessToken'] as String);
      saveRefreshToken(data['refreshToken'] as String);
      // Registering signs the user straight in, so keep the session across
      // restarts regardless of any earlier "Remember me" choice.
      Prefs.setBool(kRememberMe, true);
      return const Right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await apiService.post(EndPoints.logout, data: const {});
      clearTokens();
      return const Right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(
    DeleteAccountRequestModel deleteAccountRequestModel,
  ) async {
    try {
      await apiService.delete(
        EndPoints.deleteMe,
        data: deleteAccountRequestModel.toJson(),
      );
      clearTokens();
      return const Right(null);
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

  @override
  void clearTokens() {
    Prefs.removeData(key: kToken);
    Prefs.removeData(key: kRefreshToken);
  }
}
