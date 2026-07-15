import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_pharmacy_v2/features/products/data/models/product_model.dart';

class CartEntry {
  CartEntry({required this.product, this.quantity = 1});
  final ProductModel product;
  int quantity;
}

class CartCubit extends Cubit<List<CartEntry>> {
  CartCubit() : super([]);

  void add(ProductModel p) {
    final list = List<CartEntry>.of(state);
    final i = list.indexWhere((e) => e.product.id == p.id);
    if (i >= 0) {
      list[i].quantity++;
    } else {
      list.add(CartEntry(product: p));
    }
    emit(list);
  }

  void decrement(ProductModel p) {
    final list = List<CartEntry>.of(state);
    final i = list.indexWhere((e) => e.product.id == p.id);
    if (i < 0) return;
    if (list[i].quantity <= 1) {
      list.removeAt(i);
    } else {
      list[i].quantity--;
    }
    emit(list);
  }

  void remove(ProductModel p) =>
      emit(state.where((e) => e.product.id != p.id).toList());

  double get total => state.fold(
    0.0,
    (s, e) => s + (e.product.sellingPrice ?? e.product.price ?? 0) * e.quantity,
  );
}
