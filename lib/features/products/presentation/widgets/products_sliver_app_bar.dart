import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/widgets/cached_network_image_widget.dart';
import 'package:new_pharmacy_v2/core/models/static_product.dart';
import 'package:new_pharmacy_v2/features/wishlist/cubit/wishlist_cubit.dart';

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({super.key, required this.product});

  final StaticProduct product;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: AppColors.primaryDark,
      leading: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: CircleAvatar(
          backgroundColor: Colors.black26,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.r),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      actions: [
        BlocSelector<WishlistCubit, List<StaticProduct>, bool>(
          selector: (state) => state.any((p) => p.imageUrl == product.imageUrl),
          builder: (context, isWishlisted) => Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isWishlisted ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    key: ValueKey(isWishlisted),
                    color: isWishlisted ? Colors.redAccent : Colors.white,
                    size: 20.r,
                  ),
                ),
                onPressed: () => context.read<WishlistCubit>().toggle(product),
              ),
            ),
          ),
        ),
      ],
      title: Text(
        product.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-image-${product.imageUrl}',
          child: CachedNetworkImageWidget(
            imageUrl: product.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}