import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/bundle_model.dart';
import '../widgets/bundle_detail_app_bar.dart';
import '../widgets/bundle_info.dart';
import '../widgets/bundle_products_list.dart';

class BundleDetailScreen extends StatelessWidget {
  const BundleDetailScreen({super.key, required this.bundle});

  final BundleModel bundle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            BundleDetailAppBar(bundle: bundle),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BundleInfo(bundle: bundle),
                      24.verticalSpace,
                      Divider(
                        color: theme.colorScheme.outlineVariant,
                        thickness: 1,
                      ),
                      24.verticalSpace,
                      BundleProductsList(products: bundle.products),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
