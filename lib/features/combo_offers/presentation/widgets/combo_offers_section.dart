import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../data/repos/combo_offers_repo.dart';
import '../cubits/combo_offers_cubit.dart';
import '../cubits/combo_offers_state.dart';
import 'combo_offers_header.dart';
import 'combo_offers_list.dart';
import 'combo_offers_loading.dart';

class ComboOffersSection extends StatelessWidget {
  const ComboOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ComboOffersCubit(getIt<ComboOffersRepo>())..getActiveComboOffers(),
      child: const _ComboOffersBody(),
    );
  }
}

class _ComboOffersBody extends StatelessWidget {
  const _ComboOffersBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ComboOffersCubit, ComboOffersState>(
      builder: (context, state) {
        final isLoading =
            state.status == ComboOffersStatus.initial ||
            state.status == ComboOffersStatus.loading;
        final isEmptyOrError =
            state.status == ComboOffersStatus.error ||
            (state.status == ComboOffersStatus.loaded && state.comboOffers.isEmpty);

        if (isEmptyOrError) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          color: colorScheme.primaryContainer,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.verticalSpace,
              const ComboOffersHeader(),
              16.verticalSpace,
              SizedBox(
                height: 270.h,
                child: isLoading
                    ? const ComboOffersLoading()
                    : ComboOffersList(comboOffers: state.comboOffers),
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
