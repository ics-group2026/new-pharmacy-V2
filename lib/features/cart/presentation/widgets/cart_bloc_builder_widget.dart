import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/features/cart/cubit/cart_cubit.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/cart_item_row.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/empty_state.dart';
import 'package:new_pharmacy_v2/features/cart/presentation/widgets/order_summary.dart';

class CartBlocBuilderWidget extends StatelessWidget {
  const CartBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartEntry>>(
        builder: (_, items) => items.isEmpty
            ? const EmptyState()
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => CartItemRow(entry: items[i]),
                      childCount: items.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
                      child: const OrderSummary(),
                    ),
                  ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 100.h)),
                ],
              ),
      );
  }
}