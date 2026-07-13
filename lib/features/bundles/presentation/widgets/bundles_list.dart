import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/bundle_model.dart';
import 'bundle_card.dart';

class BundlesList extends StatelessWidget {
  const BundlesList({super.key, required this.bundles});

  final List<BundleModel> bundles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: bundles.length,
      separatorBuilder: (_, _) => 12.horizontalSpace,
      itemBuilder: (_, index) =>
          BundleCard(bundle: bundles[index], width: 160.w, imageHeight: 140.h),
    );
  }
}
