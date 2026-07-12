import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_translations.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
        successMessage: null,
      ),
    );
    final result = await authRepo.login(
      LoginRequestModel(email: email, password: password),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, errorMessage: failure.errMessage),
      ),
      (user) => emit(
        state.copyWith(
          status: AuthStatus.loginSuccess,
          successMessage: AppTranslations.t('auth.login_success'),
        ),
      ),
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        errorMessage: null,
        successMessage: null,
      ),
    );
    final result = await authRepo.register(
      RegisterRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(status: AuthStatus.error, errorMessage: failure.errMessage),
      ),
      (user) => emit(
        state.copyWith(
          status: AuthStatus.registerSuccess,
          successMessage: AppTranslations.t('auth.register_success'),
        ),
      ),
    );
  }
}
