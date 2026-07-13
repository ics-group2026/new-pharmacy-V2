import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/delete_account_request_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login(LoginRequestModel loginRequestModel);
  Future<Either<Failure, void>> register(
    RegisterRequestModel createAccountModel,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> deleteAccount(
    DeleteAccountRequestModel deleteAccountRequestModel,
  );
  void saveToken(String token);
  void saveRefreshToken(String refreshToken);
  void clearTokens();
}
