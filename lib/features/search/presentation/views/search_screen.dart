import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/hero_tags.dart';
import '../../../../../core/services/setup_service_locator.dart';
import '../../../../../core/utils/app_translations.dart';
import '../../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../../core/widgets/product_card.dart';
import '../../../../../core/widgets/search_field_bar.dart';
import '../../../products/data/repos/products_repo.dart';
import '../../../products/presentation/widgets/products_loading.dart';
import '../cubits/search_cubit.dart';
import '../cubits/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(getIt<ProductsRepo>()),
      child: const _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _autofocusHandled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_autofocusHandled) return;
    _autofocusHandled = true;
    // Focus once the Hero flight into this screen has finished, so the
    // keyboard doesn't pop up mid-animation and cause jank.
    final animation = ModalRoute.of(context)?.animation;
    if (animation == null || animation.isCompleted) {
      _focusNode.requestFocus();
      return;
    }
    void listener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _focusNode.requestFocus();
        animation.removeStatusListener(listener);
      }
    }

    animation.addStatusListener(listener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<SearchCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Hero(
              tag: HeroTags.searchBar,
              child: SearchFieldBar(
                controller: _controller,
                focusNode: _focusNode,
                onChanged: (query) => context.read<SearchCubit>().onQueryChanged(query),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.status == SearchStatus.initial) {
                  return const _EmptySearchState();
                }

                if (state.status == SearchStatus.loading) {
                  return const ProductsGridLoading();
                }

                if (state.status == SearchStatus.error && state.products.isEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? AppTranslations.t('common.no_data'),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state.products.isEmpty) {
                  return const EmptyDataPlaceholder(messageKey: 'search.no_results');
                }

                return GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: state.products.length + (state.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ProductCard(
                      product: state.products[index],
                      enableHero: false,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 72.r,
            color: colorScheme.onSurface.withValues(alpha: 0.15),
          ),
          20.verticalSpace,
          Text(
            AppTranslations.t('search.empty_title'),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          8.verticalSpace,
          Text(
            AppTranslations.t('search.empty_subtitle'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
