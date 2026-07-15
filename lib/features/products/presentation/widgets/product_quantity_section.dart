import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/features/products/cubit/quantity_cubit.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/quantity_widget.dart';

class ProductQuantitySection extends StatelessWidget {
  const ProductQuantitySection({
    super.key,
    required this.theme,
    required this.colorScheme,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuantityCubit>();
    return BlocBuilder<QuantityCubit, int>(
      builder: (_, quantity) => QuantityWidget(
        quantity: quantity,
        increment: cubit.increment,
        decrement: cubit.decrement,
        theme: theme,
        colorScheme: colorScheme,
      ),
    );
  }
}
