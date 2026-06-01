import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../banners/presentation/widgets/banners_carousel.dart';
import '../../../categories/presentation/widgets/categories_section.dart';
import '../../../flash_deals/presentation/widgets/flash_deals_section.dart';
import '../../../new_arrivals/presentation/widgets/new_arrivals_section.dart';
import '../../../products/presentation/widgets/best_seller_section.dart';
import '../../../products/presentation/widgets/on_sale_section.dart';
import '../../../products/presentation/widgets/top_rated_section.dart';
import '../../../trending/presentation/widgets/trending_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const HomeAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 4.h),
                  child: Column(
                    children: [
                      SearchWidget(onTap: () => context.push(AppRoutes.search)),
                      16.verticalSpace,
                      const BannersCarousel(),
                      20.verticalSpace,
                      const CategoriesSection(),
                    ],
                  ),
                ),
                const FlashDealsSection(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    children: [
                      const BestSellerSection(),
                      24.verticalSpace,
                      const TopRatedSection(),
                      24.verticalSpace,
                      const OnSaleSection(),
                    ],
                  ),
                ),
                const NewArrivalsSection(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                  child: const TrendingSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
