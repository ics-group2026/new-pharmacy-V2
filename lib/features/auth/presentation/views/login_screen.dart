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
import '../../data/models/device_info_model.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../utils/auth_validators.dart';
import '../widgets/auth_footer_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      device: DeviceInfoModel.current(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.error && state.errorMessage != null) {
              context.showErrorSnackBar(
                state.errorMessage!,
                background: Colors.red,
              );
            } else if (state.status == AuthStatus.loginSuccess) {
              context.go(AppRoutes.navBar);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TText(
                      'auth.login_title',
                      style: theme.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    TText(
                      'auth.login_subtitle',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
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
                    SizedBox(height: 32.h),
                    CustomButton(
                      text: 'auth.login_btn',
                      isLoading: state.isLoading,
                      onPressed: state.isLoading ? () {} : _submit,
                    ),
                    SizedBox(height: 24.h),
                    AuthFooterLink(
                      promptKey: 'auth.no_account',
                      actionKey: 'auth.register_link',
                      onTap: () => context.push(AppRoutes.register),
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
