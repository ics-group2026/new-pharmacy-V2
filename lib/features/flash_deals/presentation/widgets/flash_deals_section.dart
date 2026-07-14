import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../data/models/flash_deal_model.dart';
import '../../data/repos/flash_deals_repo.dart';
import '../cubits/flash_deals_cubit.dart';
import '../cubits/flash_deals_state.dart';
import 'flash_deals_header.dart';
import 'flash_deals_list.dart';
import 'flash_deals_loading.dart';

class FlashDealsSection extends StatelessWidget {
  const FlashDealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          FlashDealsCubit(getIt<FlashDealsRepo>())..getActiveFlashDeals(),
      child: const _FlashDealsBody(),
    );
  }
}

class _FlashDealsBody extends StatelessWidget {
  const _FlashDealsBody();

  DateTime? _soonestEndsAt(List<FlashDealModel> deals) {
    final endings = deals.map((d) => d.endsAt).whereType<DateTime>();
    if (endings.isEmpty) return null;
    return endings.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashDealsCubit, FlashDealsState>(
      builder: (context, state) {
        // A dead section is worse than no section — stay quiet on failure,
        // and once loaded with nothing to sell, take the space back.
        if (state.status == FlashDealsStatus.error) {
          return const SizedBox.shrink();
        }
        if (state.status == FlashDealsStatus.loaded && state.flashDeals.isEmpty) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == FlashDealsStatus.initial ||
            state.status == FlashDealsStatus.loading;

        return Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.primaryContainer,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              FlashDealsHeader(soonestEndsAt: _soonestEndsAt(state.flashDeals)),
              16.verticalSpace,
              SizedBox(
                height: 240.h,
                child: isLoading
                    ? const FlashDealsLoading()
                    : FlashDealsList(flashDeals: state.flashDeals),
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
