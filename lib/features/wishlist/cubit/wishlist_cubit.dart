import 'package:flutter_bloc/flutter_bloc.dart';

import '../../flash_deals/data/models/flash_deal_model.dart';

class WishlistCubit extends Cubit<List<FlashDealModel>> {
  WishlistCubit() : super([]);

  void toggle(FlashDealModel p) {
    final list = List<FlashDealModel>.of(state);
    final i = list.indexWhere((e) => e.imageUrl == p.imageUrl);
    i >= 0 ? list.removeAt(i) : list.add(p);
    emit(list);
  }

  bool contains(FlashDealModel p) => state.any((e) => e.imageUrl == p.imageUrl);
}
