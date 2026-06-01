import 'package:flutter/material.dart';

import '../../../../../core/widgets/cached_network_image_widget.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: CachedNetworkImageWidget(
        imageUrl: imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
