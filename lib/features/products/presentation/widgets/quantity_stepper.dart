import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/features/products/presentation/widgets/step_button.dart' show StepButton;

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({super.key, 
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        StepButton(
          icon: Icons.remove_rounded,
          onTap: quantity > 1 ? onDecrement : null,
          colorScheme: colorScheme,
        ),
        SizedBox(
          width: 52.w,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Text(
                '$quantity',
                key: ValueKey(quantity),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
        StepButton(
          icon: Icons.add_rounded,
          onTap: onIncrement,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}