import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../data/repos/banners_repo.dart';
import '../cubits/banners_cubit.dart';
import '../cubits/banners_state.dart';
import 'banner_item.dart';
import 'banners_loading.dart';
import 'dots_indicator.dart';

class BannersCarousel extends StatelessWidget {
  const BannersCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BannersCubit(getIt<BannersRepo>())..getStorefrontBanners(),
      child: const _BannersBody(),
    );
  }
}

class _BannersBody extends StatefulWidget {
  const _BannersBody();

  @override
  State<_BannersBody> createState() => _BannersBodyState();
}

class _BannersBodyState extends State<_BannersBody> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.22;

    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        if (state.status == BannersStatus.error) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == BannersStatus.initial ||
            state.status == BannersStatus.loading;
        if (isLoading) {
          return SizedBox(height: height, child: BannersLoading(height: height));
        }

        final banners = state.banners;
        // Nothing to show — collapse rather than leaving an empty carousel.
        if (banners.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context, index, _) =>
                  BannerItem(imageUrl: banners[index].imageUrl),
              options: CarouselOptions(
                height: height,
                autoPlay: banners.length > 1,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: true,
                enlargeFactor: 0.15,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    setState(() => _currentIndex = index),
              ),
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.012),
            DotsIndicator(count: banners.length, current: _currentIndex),
          ],
        );
      },
    );
  }
}
