import '../../data/models/user_model.dart';

enum AuthStatus { initial, loading, loginSuccess, registerSuccess, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? successMessage;
  final UserModel? user;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.user,
  });

  bool get isLoading => status == AuthStatus.loading;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? successMessage,
    UserModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      user: user ?? this.user,
    );
  }
}
