import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharamacy_theme_v1/features/cart/cubit/cart_cubit.dart';

class CartBlocSelectorWidget extends StatelessWidget {
  const CartBlocSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, List<CartEntry>, int>(
      selector: (s) => s.length,
      builder: (_, count) => count == 0
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
