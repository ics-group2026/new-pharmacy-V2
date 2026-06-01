import 'package:flutter/material.dart';
import '../../../../../core/widgets/t_text.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TText('nav_bar.wishlist'),
      ),
      body: const Center(
        child: TText('nav_bar.wishlist'),
      ),
    );
  }
}
