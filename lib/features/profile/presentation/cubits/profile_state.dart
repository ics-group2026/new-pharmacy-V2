import '../../../auth/data/models/user_model.dart';

enum ProfileStatus { initial, loading, loaded, updating, updateSuccess, error }

class ProfileState {
  final ProfileStatus status;
  final String? errorMessage;
  final String? successMessage;
  final UserModel? user;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.user,
  });

  bool get isLoading => status == ProfileStatus.loading;
  bool get isUpdating => status == ProfileStatus.updating;

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    String? successMessage,
    UserModel? user,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      user: user ?? this.user,
    );
  }
}
