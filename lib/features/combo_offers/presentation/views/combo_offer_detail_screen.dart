import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/combo_offer_model.dart';
import '../widgets/combo_offer_detail_app_bar.dart';
import '../widgets/combo_offer_info.dart';
import '../widgets/combo_offer_products_list.dart';

class ComboOfferDetailScreen extends StatelessWidget {
  const ComboOfferDetailScreen({super.key, required this.comboOffer});

  final ComboOfferModel comboOffer;

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
            ComboOfferDetailAppBar(comboOffer: comboOffer),
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
                      ComboOfferInfo(comboOffer: comboOffer),
                      24.verticalSpace,
                      Divider(color: theme.colorScheme.outlineVariant, thickness: 1),
                      24.verticalSpace,
                      ComboOfferProductsList(products: comboOffer.products),
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
