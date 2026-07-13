import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_translations.dart';
import '../../data/models/update_profile_request_model.dart';
import '../../data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(const ProfileState());

  /// Drops the cached user. Must be called when the session ends (logout or
  /// account deletion) — this cubit is an app-lifetime singleton, so otherwise
  /// the previous user's data would leak into the next session.
  void reset() => emit(const ProfileState());

  Future<void> getProfile() async {
    emit(
      state.copyWith(
        status: ProfileStatus.loading,
        errorMessage: null,
        successMessage: null,
      ),
    );
    final result = await profileRepo.getProfile();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (user) => emit(
        state.copyWith(status: ProfileStatus.loaded, user: user),
      ),
    );
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    emit(
      state.copyWith(
        status: ProfileStatus.updating,
        errorMessage: null,
        successMessage: null,
      ),
    );
    final result = await profileRepo.updateProfile(
      UpdateProfileRequestModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: failure.errMessage,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: ProfileStatus.updateSuccess,
          successMessage: AppTranslations.t('profile.update_success'),
          user: user,
        ),
      ),
    );
  }
}
