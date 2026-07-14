/// Static, UI-only product data. Not backed by any API — the products,
/// cart, wishlist, trending and new arrivals features have no data layer yet,
/// so their content is hardcoded against this type.
class StaticProduct {
  const StaticProduct({
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
