import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/flash_deal_model.dart';
import '../widgets/flash_deal_detail_app_bar.dart';
import '../widgets/flash_deal_info.dart';
import '../widgets/flash_deal_products_list.dart';

class FlashDealDetailScreen extends StatelessWidget {
  const FlashDealDetailScreen({super.key, required this.flashDeal});

  final FlashDealModel flashDeal;

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
            FlashDealDetailAppBar(flashDeal: flashDeal),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FlashDealInfo(flashDeal: flashDeal),
                      24.verticalSpace,
                      Divider(color: theme.colorScheme.outlineVariant, thickness: 1),
                      24.verticalSpace,
                      FlashDealProductsList(products: flashDeal.products),
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
