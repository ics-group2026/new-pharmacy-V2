import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/cached_network_image_widget.dart';
import '../../data/models/bundle_model.dart';

class BundleDetailAppBar extends StatelessWidget {
  const BundleDetailAppBar({super.key, required this.bundle});

  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 260.h,
      backgroundColor: colorScheme.surface,
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.35),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'bundle-image-${bundle.id}',
          child: CachedNetworkImageWidget(
            imageUrl: bundle.image,
            width: double.infinity,
            height: 260.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
