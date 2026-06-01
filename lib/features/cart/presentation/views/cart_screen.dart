import 'package:flutter/material.dart';
import '../../../../../core/widgets/t_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TText('nav_bar.cart'),
      ),
      body: const Center(
        child: TText('nav_bar.cart'),
      ),
    );
  }
}
