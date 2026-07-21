import 'package:flutter/material.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/product_details/quantity_widget.dart';

class ProductQuantitySection extends StatefulWidget {
  const ProductQuantitySection({
    super.key,
    required this.theme,
    required this.colorScheme,
  });

  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  State<ProductQuantitySection> createState() => _ProductQuantitySectionState();
}

class _ProductQuantitySectionState extends State<ProductQuantitySection> {
  int _quantity = 1;

  void _increment() => setState(() => _quantity++);

  void _decrement() => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1);

  @override
  Widget build(BuildContext context) {
    return QuantityWidget(
      quantity: _quantity,
      increment: _increment,
      decrement: _decrement,
      theme: widget.theme,
      colorScheme: widget.colorScheme,
    );
  }
}
