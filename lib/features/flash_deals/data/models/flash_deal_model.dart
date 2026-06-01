class FlashDealModel {
  const FlashDealModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.rating,
    this.originalPrice,
    this.discountPercent,
  });

  final String name;
  final double price;
  final String imageUrl;
  final double? rating;
  final double? originalPrice;
  final int? discountPercent;
}
