import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_translations.dart';
import '../../../../core/utils/snack_bar_helper.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/password_field.dart';
import '../../../../core/widgets/t_text.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../utils/auth_validators.dart';
import '../widgets/auth_footer_link.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final nameParts = _fullNameController.text.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.first;
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    context.read<AuthCubit>().register(
      firstName: firstName,
      lastName: lastName,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: SafeArea(
        top: false,
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.error && state.errorMessage != null) {
              context.showErrorSnackBar(
                state.errorMessage!,
                background: Colors.red,
              );
            } else if (state.status == AuthStatus.registerSuccess) {
              context.showSnackBar(
                state.successMessage!,
                background: Colors.green,
              );
              // Register already stores the tokens, so the user is signed in.
              context.go(AppRoutes.navBar);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TText(
                      'auth.register_title',
                      style: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 8.h),
                    TText(
                      'auth.register_subtitle',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    CustomTextFormField(
                      controller: _fullNameController,
                      hintText: AppTranslations.t('auth.full_name_hint'),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      validator: AuthValidators.validateFullName,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: AppTranslations.t('auth.email_hint'),
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      validator: AuthValidators.validateEmail,
                    ),
                    SizedBox(height: 16.h),
                    PasswordField(
                      controller: _passwordController,
                      hintText: AppTranslations.t('auth.password_hint'),
                      validator: AuthValidators.validatePassword,
                    ),
                    SizedBox(height: 16.h),
                    PasswordField(
                      controller: _confirmPasswordController,
                      hintText: AppTranslations.t('auth.confirm_password_hint'),
                      validator: (value) => AuthValidators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    CustomButton(
                      text: 'auth.register_btn',
                      isLoading: state.isLoading,
                      onPressed: state.isLoading ? () {} : _submit,
                    ),
                    SizedBox(height: 24.h),
                    AuthFooterLink(
                      promptKey: 'auth.have_account',
                      actionKey: 'auth.login_link',
                      onTap: () => context.go(AppRoutes.login),
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
