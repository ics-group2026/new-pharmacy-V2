import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/t_text.dart';
import 'package:new_pharmacy_v2/features/cart/cubit/cart_cubit.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/row_of_cart.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currency = AppTranslations.t('flash_deals.currency');

    return BlocBuilder<CartCubit, List<CartEntry>>(
      builder: (_, items) {
        final subtotal = items.fold(0.0, (s, e) => s + e.product.price * e.quantity);

        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TText('cart.order_summary',
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              12.verticalSpace,
              RowOfCart(labelKey: 'cart.subtotal', value: '${subtotal.toStringAsFixed(0)} $currency'),
              8.verticalSpace,
              RowOfCart(labelKey: 'cart.delivery_fee', valueKey: 'cart.free',
                  valueColor: AppColors.success),
              12.verticalSpace,
              Divider(color: colorScheme.outlineVariant, thickness: 1),
              12.verticalSpace,
              RowOfCart(labelKey: 'cart.total', value: '${subtotal.toStringAsFixed(0)} $currency',
                  bold: true),
            ],
          ),
        );
      },
    );
  }
}