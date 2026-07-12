import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/profile/presentation/widgets/labled_feilds.dart';
import 'package:new_pharmacy_v2/features/profile/presentation/widgets/profile_header.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/t_text.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/presentation/utils/auth_validators.dart';
import '../cubits/profile_cubit.dart';
import '../cubits/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ProfileCubit>().updateProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
    );
  }

  void _fillControllers(UserModel user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
  }

  void _showSnackBar(String message, {Color? background}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(backgroundColor: background, content: Text(message)),
      );
  }

  void _onStateChanged(ProfileState state) {
    switch (state.status) {
      case ProfileStatus.error:
        if (state.errorMessage != null) {
          _showSnackBar(
            state.errorMessage!,
            background: Theme.of(context).colorScheme.error,
          );
        }
      case ProfileStatus.loaded:
        if (state.user != null) _fillControllers(state.user!);
      case ProfileStatus.updateSuccess:
        if (state.user != null) _fillControllers(state.user!);
        if (state.successMessage != null) _showSnackBar(state.successMessage!);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TText('profile.title'),
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SafeArea(
        top: false,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) => _onStateChanged(state),
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileHeader(user: state.user),
                    SizedBox(height: 32.h),
                    LabeledField(
                      labelKey: 'profile.first_name',
                      controller: _firstNameController,
                      hintKey: 'profile.first_name_hint',
                      icon: Icons.person_outline,
                      validator: AuthValidators.validateRequired,
                    ),
                    SizedBox(height: 20.h),
                    LabeledField(
                      labelKey: 'profile.last_name',
                      controller: _lastNameController,
                      hintKey: 'profile.last_name_hint',
                      icon: Icons.person_outline,
                      validator: AuthValidators.validateRequired,
                    ),
                    SizedBox(height: 20.h),
                    LabeledField(
                      labelKey: 'profile.email',
                      controller: _emailController,
                      hintKey: 'profile.email_hint',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidators.validateEmail,
                    ),
                    SizedBox(height: 40.h),
                    CustomButton(
                      text: 'profile.save_btn',
                      isLoading: state.isUpdating,
                      onPressed: state.isUpdating ? () {} : _submit,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




