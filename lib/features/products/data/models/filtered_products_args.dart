class FilteredProductsArgs {
  const FilteredProductsArgs({required this.title, this.categoryId, this.brandId});

  final String title;
  final String? categoryId;
  final String? brandId;
}
