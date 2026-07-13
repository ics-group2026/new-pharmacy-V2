import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/categories_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo categoriesRepo;

  CategoriesCubit(this.categoriesRepo) : super(const CategoriesState());

  Future<void> getCategories() async {
    emit(state.copyWith(status: CategoriesStatus.loading, errorMessage: null));
    final result = await categoriesRepo.getCategories();
    result.fold(
      (failure) => emit(
        state.copyWith(status: CategoriesStatus.error, errorMessage: failure.errMessage),
      ),
      (categories) => emit(
        state.copyWith(status: CategoriesStatus.loaded, categories: categories),
      ),
    );
  }
}
