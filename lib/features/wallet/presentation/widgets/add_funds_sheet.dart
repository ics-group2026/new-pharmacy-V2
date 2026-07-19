import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_translations.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/t_text.dart';
import '../cubits/wallet_cubit.dart';
import '../cubits/wallet_state.dart';

class AddFundsSheet extends StatefulWidget {
  const AddFundsSheet({super.key});

  static Future<void> show(
    BuildContext context, {
    required WalletCubit cubit,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const AddFundsSheet()),
    );
  }

  @override
  State<AddFundsSheet> createState() => _AddFundsSheetState();
}

class _AddFundsSheetState extends State<AddFundsSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final amount = double.parse(_amountController.text.trim());
    final notes = _notesController.text.trim();
    context.read<WalletCubit>().addFunds(
      amount: amount,
      notes: notes.isEmpty ? null : notes,
    );
  }

  String? _validateAmount(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return AppTranslations.t('wallet.amount_required');
    final parsed = double.tryParse(raw);
    if (parsed == null || parsed <= 0) {
      return AppTranslations.t('wallet.amount_invalid');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

    return BlocListener<WalletCubit, WalletState>(
      listenWhen: (previous, current) =>
          previous.actionStatus != current.actionStatus,
      listener: (context, state) {
        // The screen-level listener owns the snackbars; the sheet just closes.
        if (state.actionStatus == WalletActionStatus.success &&
            state.action == WalletAction.addFunds) {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        // Lifts the sheet above the keyboard.
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                16.verticalSpace,
                TText(
                  'wallet.add_funds_title',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                16.verticalSpace,
                TText(
                  'wallet.amount',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                8.verticalSpace,
                CustomTextFormField(
                  controller: _amountController,
                  hintText: 'wallet.amount_hint',
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: _validateAmount,
                  autofocus: true,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      currency,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                16.verticalSpace,
                TText(
                  'wallet.notes',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                8.verticalSpace,
                CustomTextFormField(
                  controller: _notesController,
                  hintText: 'wallet.notes_hint',
                ),
                24.verticalSpace,
                BlocBuilder<WalletCubit, WalletState>(
                  builder: (context, state) {
                    final isSubmitting =
                        state.isSubmitting &&
                        state.action == WalletAction.addFunds;
                    return SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : _submit,
                        child: isSubmitting
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : TText('wallet.add_funds'),
                      ),
                    );
                  },
                ),
                8.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
