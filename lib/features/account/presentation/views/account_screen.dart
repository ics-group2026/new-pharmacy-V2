import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/account_preferance_content.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/services/setup_service_locator.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/utils/snack_bar_helper.dart';
import '../../../../../core/widgets/t_text.dart';
import '../../../auth/data/repos/auth_repo.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../auth/presentation/cubits/auth_state.dart';
import '../../../profile/presentation/cubits/profile_cubit.dart';
import '../../../profile/presentation/cubits/profile_state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ProfileCubit is provided by the nav shell; only AuthCubit (for logout)
    // is scoped to this screen.
    return BlocProvider(
      create: (_) => AuthCubit(getIt<AuthRepo>()),
      child: const _AccountView(),
    );
  }
}

class _AccountView extends StatelessWidget {
  const _AccountView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.logoutSuccess ||
            state.status == AuthStatus.deleteAccountSuccess) {
          if (state.successMessage != null) {
            context.showSnackBar(state.successMessage!, background: Colors.green);
          }
          // The ProfileCubit is an app-lifetime singleton — clear it so the
          // next user doesn't see the previous account's name/email.
          getIt<ProfileCubit>().reset();
          context.go(AppRoutes.login);
        } else if (state.status == AuthStatus.error && state.errorMessage != null) {
          context.showErrorSnackBar(state.errorMessage!, background: Colors.red);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryDark, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        40.verticalSpace,
                        Container(
                          width: 72.r,
                          height: 72.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            size: 38.r,
                            color: Colors.white,
                          ),
                        ),
                        12.verticalSpace,
                        const _ProfileInfo(),
                      ],
                    ),
                  ),
                ),
              ),
              title: TText(
                'nav_bar.account',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.primaryDark,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            SliverToBoxAdapter(child: AccountPreferanceContent()),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        final user = state.user;
        final hasName =
            user != null && (user.firstName.isNotEmpty || user.lastName.isNotEmpty);
        final name = hasName
            ? '${user.firstName} ${user.lastName}'.trim()
            : AppTranslations.t('home.user_name');
        final email = user?.email ?? AppTranslations.t('account.email_placeholder');

        return Column(
          children: [
            Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            4.verticalSpace,
            Text(
              email,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),
          ],
        );
      },
    );
  }
}
