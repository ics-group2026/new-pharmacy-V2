class ProductVendor {
  final String? id;
  final String? userId;
  final String? shopName;
  final String? name;
  final String? email;
  final String? avatar;
  final String? logo;
  final String? banner;
  final bool? storeAvailability;
  final ProductVendorUser? user;

  ProductVendor({
    this.id,
    this.userId,
    this.shopName,
    this.name,
    this.email,
    this.avatar,
    this.logo,
    this.banner,
    this.storeAvailability,
    this.user,
  });

  factory ProductVendor.fromJson(Map<String, dynamic> json) => ProductVendor(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    shopName: json['shopName'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    avatar: json['avatar'] as String?,
    logo: json['logo'] as String?,
    banner: json['banner'] as String?,
    storeAvailability: json['storeAvailability'] as bool?,
    user: json['user'] != null
        ? ProductVendorUser.fromJson(json['user'] as Map<String, dynamic>)
        : null,
  );
}

class ProductVendorUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? type;
  final String? status;

  ProductVendorUser({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phone,
    this.avatar,
    this.type,
    this.status,
  });

  factory ProductVendorUser.fromJson(Map<String, dynamic> json) =>
      ProductVendorUser(
        id: json['id'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        fullName: json['fullName'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        avatar: json['avatar'] as String?,
        type: json['type'] as String?,
        status: json['status'] as String?,
      );
}
