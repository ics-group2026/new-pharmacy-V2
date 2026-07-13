import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';
import 'package:new_pharmacy_v2/features/account/presentation/widgets/delete_account_dialog.dart';
import 'package:new_pharmacy_v2/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:new_pharmacy_v2/features/auth/presentation/cubits/auth_state.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final password = await showDialog<String>(
      context: context,
      builder: (_) => const DeleteAccountDialog(),
    );
    if (password != null && context.mounted) {
      context.read<AuthCubit>().deleteAccount(currentPassword: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: TextButton.icon(
            onPressed: state.isLoading ? null : () => _confirmDelete(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            icon: const Icon(Icons.delete_outline_rounded),
            label: TText('account.delete_account'),
          ),
        );
      },
    );
  }
}
