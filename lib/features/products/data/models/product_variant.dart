import '../../../../core/models/localized_text.dart';
import '../../../../core/utils/converter.dart';

class ProductVariant {
  final String? id;
  final LocalizedText? name;
  final String? sku;
  final String? barcode;
  final String? internationalBarcode;
  final double? price;
  final double? discount;
  final String? discountType;
  final int? stock;
  final DateTime? expiryDate;
  final String? status;
  final double? sellingPrice;
  final SellingPriceBreakdown? sellingPriceBreakdown;

  ProductVariant({
    this.id,
    this.name,
    this.sku,
    this.barcode,
    this.internationalBarcode,
    this.price,
    this.discount,
    this.discountType,
    this.stock,
    this.expiryDate,
    this.status,
    this.sellingPrice,
    this.sellingPriceBreakdown,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: json['id'] as String?,
    name: LocalizedText.fromJson(json['name']),
    sku: json['sku'] as String?,
    barcode: json['barcode'] as String?,
    internationalBarcode: json['internationalBarcode'] as String?,
    price: Converter.toDoubleOrNull(json['price']),
    discount: Converter.toDoubleOrNull(json['discount']),
    discountType: json['discountType'] as String?,
    stock: Converter.toIntOrNull(json['stock']),
    expiryDate: json['expiryDate'] != null
        ? DateTime.tryParse(json['expiryDate'] as String)
        : null,
    status: json['status'] as String?,
    sellingPrice: Converter.toDoubleOrNull(json['sellingPrice']),
    sellingPriceBreakdown: json['sellingPriceBreakdown'] != null
        ? SellingPriceBreakdown.fromJson(
            json['sellingPriceBreakdown'] as Map<String, dynamic>,
          )
        : null,
  );
}

class SellingPriceBreakdown {
  final double? price;
  final double? discountAmount;
  final double? discountedPrice;
  final double? taxAmount;
  final bool? taxIncluded;
  final double? profitPercent;
  final double? shippingCost;
  final bool? multiplyShippingByQty;
  final double? sellingPrice;

  SellingPriceBreakdown({
    this.price,
    this.discountAmount,
    this.discountedPrice,
    this.taxAmount,
    this.taxIncluded,
    this.profitPercent,
    this.shippingCost,
    this.multiplyShippingByQty,
    this.sellingPrice,
  });

  factory SellingPriceBreakdown.fromJson(Map<String, dynamic> json) =>
      SellingPriceBreakdown(
        price: Converter.toDoubleOrNull(json['price']),
        discountAmount: Converter.toDoubleOrNull(json['discountAmount']),
        discountedPrice: Converter.toDoubleOrNull(json['discountedPrice']),
        taxAmount: Converter.toDoubleOrNull(json['taxAmount']),
        taxIncluded: json['taxIncluded'] as bool?,
        profitPercent: Converter.toDoubleOrNull(json['profitPercent']),
        shippingCost: Converter.toDoubleOrNull(json['shippingCost']),
        multiplyShippingByQty: json['multiplyShippingByQty'] as bool?,
        sellingPrice: Converter.toDoubleOrNull(json['sellingPrice']),
      );
}
