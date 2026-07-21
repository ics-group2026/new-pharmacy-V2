import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/add_to_cart_request_model.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(AddToCartRequestModel requestModel);
}
