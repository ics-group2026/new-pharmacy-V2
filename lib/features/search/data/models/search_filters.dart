/// `sortOrder` mirrors the `/products` endpoint's `ASC`/`DESC` values, applied
/// to price since that's the only sortable field the API exposes.
enum SearchSortOrder { relevance, priceAsc, priceDesc }

class SearchFilters {
  const SearchFilters({
    this.categoryId,
    this.categoryLabel,
    this.brandId,
    this.brandLabel,
    this.minPrice,
    this.maxPrice,
    this.sortOrder = SearchSortOrder.relevance,
  });

  final String? categoryId;
  final String? categoryLabel;
  final String? brandId;
  final String? brandLabel;
  final double? minPrice;
  final double? maxPrice;
  final SearchSortOrder sortOrder;

  bool get isEmpty =>
      categoryId == null &&
      brandId == null &&
      minPrice == null &&
      maxPrice == null &&
      sortOrder == SearchSortOrder.relevance;

  int get activeCount =>
      (categoryId != null ? 1 : 0) +
      (brandId != null ? 1 : 0) +
      (minPrice != null || maxPrice != null ? 1 : 0) +
      (sortOrder != SearchSortOrder.relevance ? 1 : 0);

  String? get apiSortOrder => switch (sortOrder) {
    SearchSortOrder.relevance => null,
    SearchSortOrder.priceAsc => 'ASC',
    SearchSortOrder.priceDesc => 'DESC',
  };

  SearchFilters copyWith({
    String? categoryId,
    String? categoryLabel,
    String? brandId,
    String? brandLabel,
    double? minPrice,
    double? maxPrice,
    SearchSortOrder? sortOrder,
  }) {
    return SearchFilters(
      categoryId: categoryId ?? this.categoryId,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      brandId: brandId ?? this.brandId,
      brandLabel: brandLabel ?? this.brandLabel,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  SearchFilters clearCategory() => SearchFilters(
    brandId: brandId,
    brandLabel: brandLabel,
    minPrice: minPrice,
    maxPrice: maxPrice,
    sortOrder: sortOrder,
  );

  SearchFilters clearBrand() => SearchFilters(
    categoryId: categoryId,
    categoryLabel: categoryLabel,
    minPrice: minPrice,
    maxPrice: maxPrice,
    sortOrder: sortOrder,
  );

  SearchFilters clearPriceRange() => SearchFilters(
    categoryId: categoryId,
    categoryLabel: categoryLabel,
    brandId: brandId,
    brandLabel: brandLabel,
    sortOrder: sortOrder,
  );

  SearchFilters clearSort() => SearchFilters(
    categoryId: categoryId,
    categoryLabel: categoryLabel,
    brandId: brandId,
    brandLabel: brandLabel,
    minPrice: minPrice,
    maxPrice: maxPrice,
  );
}
