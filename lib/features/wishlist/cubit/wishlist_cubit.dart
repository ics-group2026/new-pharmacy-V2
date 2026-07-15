import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class WishlistCubit extends Cubit<List<ProductModel>> {
  WishlistCubit() : super([]);

  void toggle(ProductModel p) {
    final list = List<ProductModel>.of(state);
    final i = list.indexWhere((e) => e.id == p.id);
    i >= 0 ? list.removeAt(i) : list.add(p);
    emit(list);
  }

  bool contains(ProductModel p) => state.any((e) => e.id == p.id);
}
