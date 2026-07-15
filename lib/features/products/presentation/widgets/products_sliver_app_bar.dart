import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_pharmacy_v2/core/utils/app_colors.dart';
import 'package:new_pharmacy_v2/core/widgets/cached_network_image_widget.dart';
import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';
import 'package:new_pharmacy_v2/features/wishlist/cubit/wishlist_cubit.dart';

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({super.key, required this.product, this.galleryUrls});

  final ProductModel product;

  /// Full image set from the details endpoint. When more than one is present
  /// the header becomes a swipeable gallery; otherwise it shows the single
  /// Hero image carried over from the list.
  final List<String>? galleryUrls;

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
        BlocSelector<WishlistCubit, List<ProductModel>, bool>(
          selector: (state) => state.any((p) => p.id == product.id),
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
        product.name ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      flexibleSpace: FlexibleSpaceBar(background: _buildBackground()),
    );
  }

  Widget _buildBackground() {
    final urls = galleryUrls;
    if (urls != null && urls.length > 1) {
      return _GalleryBackground(urls: urls);
    }
    final imageUrl = product.image?.url ?? '';
    return Hero(
      tag: 'product-image-${product.id ?? imageUrl}',
      child: CachedNetworkImageWidget(
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _GalleryBackground extends StatefulWidget {
  const _GalleryBackground({required this.urls});

  final List<String> urls;

  @override
  State<_GalleryBackground> createState() => _GalleryBackgroundState();
}

class _GalleryBackgroundState extends State<_GalleryBackground> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.urls.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) => CachedNetworkImageWidget(
            imageUrl: widget.urls[i],
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 12.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.urls.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: _index == i ? 18.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: _index == i ? Colors.white : Colors.white54,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}