import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/cart/data/models/cart_entry.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/cart_item_row.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/order_summary.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_image.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import '../../../../../core/widgets/t_text.dart';

// Cart cubit was removed; this static sample data stands in for the
// screen's state until the feature is rebuilt on top of the new cart data.
final _staticCartEntries = [
  CartEntry(
    product: const ProductModel(
      id: '1',
      name: 'Panadol Extra 24 Tablets',
      price: 25,
      sellingPrice: 20,
      image: ProductImage(url: 'https://picsum.photos/seed/panadol/200'),
    ),
    quantity: 2,
  ),
  CartEntry(
    product: const ProductModel(
      id: '2',
      name: 'Vitamin C 1000mg 30 Tablets',
      price: 45,
      image: ProductImage(url: 'https://picsum.photos/seed/vitaminc/200'),
    ),
    quantity: 1,
  ),
];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = _staticCartEntries;

    return Scaffold(
      appBar: AppBar(title: const TText('nav_bar.cart')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8.h),
                itemCount: entries.length,
                itemBuilder: (context, index) => CartItemRow(entry: entries[index]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
              child: OrderSummary(items: entries),
            ),
            SizedBox(height: 32.h), // Space for the bottom navigation bar
          ],
        ),
      ),
    );
  }
}
