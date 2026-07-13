import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/animated_fade_slide.dart';
import '../../../banners/presentation/widgets/banners_carousel.dart';
import '../../../bundles/presentation/widgets/bundles_section.dart';
import '../../../categories/presentation/widgets/categories_section.dart';
import '../../../combo_offers/presentation/widgets/combo_offers_section.dart';
import '../../../new_arrivals/presentation/widgets/new_arrivals_section.dart';
import '../../../products/presentation/widgets/best_seller_section.dart';
import '../../../products/presentation/widgets/on_sale_section.dart';
import '../../../products/presentation/widgets/top_rated_section.dart';
import '../../../trending/presentation/widgets/trending_section.dart';
import '../widgets/home_app_bar.dart';

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
            child: AnimatedFadeSlide(
              delay: Duration.zero,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                child: const BannersCarousel(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 80),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                child: const CategoriesSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 160),
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: const ComboOffersSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 200),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: const BundlesSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 240),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: const BestSellerSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 280),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: const TopRatedSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 320),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: const OnSaleSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 360),
              child: Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: const NewArrivalsSection(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedFadeSlide(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: const TrendingSection(),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 100.h)),
        ],
      ),
    );
  }
}
