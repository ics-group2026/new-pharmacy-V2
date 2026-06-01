import 'package:flutter_bloc/flutter_bloc.dart';

import '../../flash_deals/data/models/flash_deal_model.dart';

class CartEntry {
  CartEntry({required this.product, this.quantity = 1});
  final FlashDealModel product;
  int quantity;
}

class CartCubit extends Cubit<List<CartEntry>> {
  CartCubit() : super([]);

  void add(FlashDealModel p) {
    final list = List<CartEntry>.of(state);
    final i = list.indexWhere((e) => e.product.imageUrl == p.imageUrl);
    if (i >= 0) {
      list[i].quantity++;
    } else {
      list.add(CartEntry(product: p));
    }
    emit(list);
  }

  void decrement(FlashDealModel p) {
    final list = List<CartEntry>.of(state);
    final i = list.indexWhere((e) => e.product.imageUrl == p.imageUrl);
    if (i < 0) return;
    if (list[i].quantity <= 1) {
      list.removeAt(i);
    } else {
      list[i].quantity--;
    }
    emit(list);
  }

  void remove(FlashDealModel p) =>
      emit(state.where((e) => e.product.imageUrl != p.imageUrl).toList());

  double get total => state.fold(0.0, (s, e) => s + e.product.price * e.quantity);
}
