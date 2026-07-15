import '../../../../core/utils/converter.dart';

class ProductImage {
  final String? id;
  final String? url;
  final bool? isMain;
  final int? sortOrder;
  final String? altText;

  const ProductImage({
    this.id,
    this.url,
    this.isMain,
    this.sortOrder,
    this.altText,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json['id'] as String?,
    url: json['url'] as String?,
    isMain: json['isMain'] as bool?,
    sortOrder: Converter.toIntOrNull(json['sortOrder']),
    altText: json['altText'] as String?,
  );
}
