import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/features/cart/cubit/cart_cubit.dart';
import 'package:new_pharmacy_v2/features/products/cubit/quantity_cubit.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'package:new_pharmacy_v2/features/products/presentation/widgets/add_to_cart_bar.dart';

class ProductDetailBottomBar extends StatelessWidget {
  const ProductDetailBottomBar({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final unitPrice = product.sellingPrice ?? product.price ?? 0;
    return BlocBuilder<QuantityCubit, int>(
      builder: (context, quantity) => AddToCartBar(
        totalPrice: unitPrice * quantity,
        currency: AppTranslations.t('flash_deals.currency'),
        onAddToCart: () {
          final cart = context.read<CartCubit>();
          for (var i = 0; i < quantity; i++) {
            cart.add(product);
          }
        },
      ),
    );
  }
}
