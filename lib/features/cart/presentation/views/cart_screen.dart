import 'package:flutter/material.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/cart_bloc_builder_widget.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/cart_bloc_selector_widget.dart';
import '../../../../../core/widgets/t_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TText('nav_bar.cart'),
        actions: [
          CartBlocSelectorWidget()
        ],
      ),
      body: CartBlocBuilderWidget()
    );
  }
}






