import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_pharmacy_v2/core/models/static_product.dart';

class WishlistCubit extends Cubit<List<StaticProduct>> {
  WishlistCubit() : super([]);

  void toggle(StaticProduct p) {
    final list = List<StaticProduct>.of(state);
    final i = list.indexWhere((e) => e.imageUrl == p.imageUrl);
    i >= 0 ? list.removeAt(i) : list.add(p);
    emit(list);
  }

  bool contains(StaticProduct p) => state.any((e) => e.imageUrl == p.imageUrl);
}
