import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/features/cart/presentation/widgets/empty_state.dart';
import 'package:new_pharamacy_theme_v1/features/cart/presentation/widgets/order_summary.dart';
import '../../../../../core/widgets/t_text.dart';
import '../../cubit/cart_cubit.dart';
import '../widgets/cart_item_row.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TText('nav_bar.cart'),
        actions: [
          BlocSelector<CartCubit, List<CartEntry>, int>(
            selector: (s) => s.length,
            builder: (_, count) => count == 0
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text('$count',
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, List<CartEntry>>(
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
      ),
    );
  }
}






