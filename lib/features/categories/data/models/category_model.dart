import '../../../../core/utils/converter.dart';

class CategoryModel {
  String? id;
  String? arName;
  String? enName;
  String? image;
  String? parentId;
  int? sortOrder;
  int? homeProductsLimit;
  String? homeProductsSortBy;
  String? status;
  int? totalSubcategories;

  CategoryModel({
    this.id,
    this.arName,
    this.enName,
    this.image,
    this.parentId,
    this.sortOrder,
    this.homeProductsLimit,
    this.homeProductsSortBy,
    this.status,
    this.totalSubcategories,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    final name = json['name'];
    if (name is Map<String, dynamic>) {
      arName = name['ar'];
      enName = name['en'];
    } else if (name is String) {
      arName = name;
      enName = name;
    }
    image = json['image'];
    parentId = json['parentId'];
    sortOrder = Converter.toIntOrNull(json['sortOrder']);
    homeProductsLimit = Converter.toIntOrNull(json['homeProductsLimit']);
    homeProductsSortBy = json['homeProductsSortBy'];
    status = json['status'];
    totalSubcategories = Converter.toIntOrNull(json['totalSubcategories']);
  }
}

