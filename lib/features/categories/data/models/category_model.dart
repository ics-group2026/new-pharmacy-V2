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
    arName = json['name']['ar'];
    enName = json['name']['en'];
    image = json['image'];
    parentId = json['parentId'];
    sortOrder = json['sortOrder'];
    homeProductsLimit = json['homeProductsLimit'];
    homeProductsSortBy = json['homeProductsSortBy'];
    status = json['status'];
    totalSubcategories = json['totalSubcategories'];
  }
}

