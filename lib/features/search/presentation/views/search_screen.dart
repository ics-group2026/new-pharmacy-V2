import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_pharmacy_v2/core/services/setup_service_locator.dart';
import 'package:new_pharmacy_v2/core/utils/app_translations.dart';
import 'package:new_pharmacy_v2/features/search/presentation/cubits/search_cubit.dart';
import 'package:new_pharmacy_v2/features/search/presentation/cubits/search_state.dart';
import 'package:new_pharmacy_v2/features/search/presentation/utils/hero_autofocus.dart';
import 'package:new_pharmacy_v2/features/search/presentation/widgets/active_filters_row.dart';
import 'package:new_pharmacy_v2/features/search/presentation/widgets/search_bar_row.dart';
import 'package:new_pharmacy_v2/features/search/presentation/widgets/search_filters_sheet.dart';
import 'package:new_pharmacy_v2/features/search/presentation/widgets/search_idle_content.dart';
import 'package:new_pharmacy_v2/features/search/presentation/widgets/search_results_grid.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: getIt<SearchCubit>(), child: const _SearchBody());
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _autofocusHandled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: context.read<SearchCubit>().state.query);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_autofocusHandled) return;
    _autofocusHandled = true;
    attachHeroAutofocus(context, _focusNode);
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

  Future<void> _openFilters(SearchState state) async {
    final result = await showSearchFiltersSheet(context, initialFilters: state.filters);
    if (result != null && mounted) {
      context.read<SearchCubit>().applyFilters(result);
    }
  }

  void _selectTerm(String term) {
    _controller.text = term;
    context.read<SearchCubit>().submitSearch(term);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<SearchCubit, SearchState>(
      listenWhen: (previous, current) => previous.query != current.query,
      listener: (context, state) {
        if (_controller.text != state.query) _controller.text = state.query;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppTranslations.t('search.title')),
            centerTitle: true,
          ),
          backgroundColor: colorScheme.surface,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w).copyWith(top: 16.h),
            child: Column(
              children: [
                SearchBarRow(
                  controller: _controller,
                  focusNode: _focusNode,
                  onQueryChanged: (query) =>
                      context.read<SearchCubit>().onQueryChanged(query),
                  activeFilterCount: state.filters.activeCount,
                  onFilterTap: () => _openFilters(state),
                ),
                12.verticalSpace,
                if (!state.filters.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: ActiveFiltersRow(
                      filters: state.filters,
                      onChanged: (filters) =>
                          context.read<SearchCubit>().applyFilters(filters),
                    ),
                  ),
                Expanded(
                  child: state.status == SearchStatus.initial
                      ? SearchIdleContent(
                          recentSearches: state.recentSearches,
                          onSelect: _selectTerm,
                          onClearRecent: () =>
                              context.read<SearchCubit>().clearRecentSearches(),
                        )
                      : SearchResultsGrid(
                          state: state,
                          scrollController: _scrollController,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
