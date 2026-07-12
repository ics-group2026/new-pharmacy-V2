import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(LoginRequestModel loginRequestModel);
  Future<Either<Failure, UserModel>> register(
    RegisterRequestModel createAccountModel,
  );
  void saveToken(String token);
  void saveRefreshToken(String refreshToken);
}
