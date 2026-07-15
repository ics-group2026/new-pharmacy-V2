import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/cached_network_image_widget.dart';
import '../../cubit/cart_cubit.dart';

class CartItemRow extends StatelessWidget {
  const CartItemRow({super.key, required this.entry});

  final CartEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cubit = context.read<CartCubit>();
    final currency = AppTranslations.t('flash_deals.currency');
    final product = entry.product;
    final unitPrice = product.sellingPrice ?? product.price ?? 0;

    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => cubit.remove(entry.product),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: EdgeInsetsDirectional.only(end: 24.w),
        color: AppColors.error,
        child: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26.r),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(12.r),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImageWidget(
                imageUrl: product.image?.url ?? '',
                width: 72.r,
                height: 72.r,
                fit: BoxFit.cover,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      height: 1.35,
                    ),
                  ),
                  6.verticalSpace,
                  Text(
                    '${(unitPrice * entry.quantity).toStringAsFixed(0)} $currency',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      _StepButton(
                        icon: Icons.remove_rounded,
                        enabled: entry.quantity > 1,
                        onTap: () => cubit.decrement(entry.product),
                      ),
                      SizedBox(
                        width: 36.w,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            transitionBuilder: (child, anim) =>
                                FadeTransition(opacity: anim, child: child),
                            child: Text(
                              '${entry.quantity}',
                              key: ValueKey(entry.quantity),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _StepButton(
                        icon: Icons.add_rounded,
                        enabled: true,
                        onTap: () => cubit.add(entry.product),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => cubit.remove(entry.product),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 20.r,
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        tooltip: AppTranslations.t('cart.remove'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.enabled, required this.onTap});

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          color: enabled
              ? colorScheme.primary
              : colorScheme.onSurface.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          size: 16.r,
          color: enabled ? Colors.white : colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
