import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/core/widgets/animated_fade_slide.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_details/quantity_stepper.dart';
    

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.increment,
    required this.decrement,
    required this.theme,
    required this.colorScheme,
  });
  final int quantity;
  final VoidCallback increment;
  final VoidCallback decrement;
  final ThemeData theme;
  final ColorScheme colorScheme;  


  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 260),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTranslations.t('product_detail.quantity'),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          12.verticalSpace,
          QuantityStepper(
            quantity: quantity,
            onIncrement: increment,
            onDecrement: decrement,
          ),
        ],
      ),
    );
  }
}
