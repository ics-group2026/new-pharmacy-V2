import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/services/setup_service_locator.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../data/repos/bundles_repo.dart';
import '../cubits/bundles_cubit.dart';
import '../cubits/bundles_state.dart';
import 'bundles_header.dart';
import 'bundles_list.dart';
import 'bundles_loading.dart';

class BundlesSection extends StatelessWidget {
  const BundlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BundlesCubit(getIt<BundlesRepo>())..getActiveBundles(),
      child: const _BundlesBody(),
    );
  }
}

class _BundlesBody extends StatelessWidget {
  const _BundlesBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BundlesCubit, BundlesState>(
      builder: (context, state) {
        if (state.status == BundlesStatus.error) {
          return const SizedBox.shrink();
        }

        final isLoading =
            state.status == BundlesStatus.initial ||
            state.status == BundlesStatus.loading;
        final isEmpty =
            state.status == BundlesStatus.loaded && state.bundles.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BundlesHeader(),
            16.verticalSpace,
            SizedBox(
              height: 270.h,
              child: isLoading
                  ? const BundlesLoading()
                  : isEmpty
                  ? const EmptyDataPlaceholder()
                  : BundlesList(bundles: state.bundles),
            ),
          ],
        );
      },
    );
  }
}
