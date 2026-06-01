import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'banner_item.dart';
import 'dots_indicator.dart';

class BannersCarousel extends StatefulWidget {
  const BannersCarousel({super.key});

  @override
  State<BannersCarousel> createState() => _BannersCarouselState();
}

class _BannersCarouselState extends State<BannersCarousel> {
  static const _bannerUrls = [
    'https://picsum.photos/seed/pharma1/800/350',
    'https://picsum.photos/seed/pharma2/800/350',
    'https://picsum.photos/seed/pharma3/800/350',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _bannerUrls.length,
          itemBuilder: (context, index, _) =>
              BannerItem(imageUrl: _bannerUrls[index]),
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.22,
            autoPlay: true,
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
        DotsIndicator(count: _bannerUrls.length, current: _currentIndex),
      ],
    );
  }
}
