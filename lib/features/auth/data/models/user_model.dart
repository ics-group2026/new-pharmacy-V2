class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final String type;
  final String? avatar;
  final String? phone;
  final String? googleProviderId;
  final String? facebookProviderId;
  final String? appleProviderId;
  final String? identityType;
  final String? identityNumber;
  final String? identityImage;
  final String? roleId;
  final String? createdAt;
  final String? updatedAt;
  // final Map<String, dynamic>? role;
  // final Map<String, dynamic>? vendorProfile;
  final String? assignedVendorId;
  // final Map<String, dynamic>? deliveryManProfile;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.type,
    this.avatar,
    this.phone,
    this.googleProviderId,
    this.facebookProviderId,
    this.appleProviderId,
    this.identityType,
    this.identityNumber,
    this.identityImage,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    // this.role,
    // this.vendorProfile,
    this.assignedVendorId,
    // this.deliveryManProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    status: json['status'] as String,
    type: json['type'] as String,
    avatar: json['avatar'] as String?,
    phone: json['phone'] as String?,
    googleProviderId: json['googleProviderId'] as String?,
    facebookProviderId: json['facebookProviderId'] as String?,
    appleProviderId: json['appleProviderId'] as String?,
    identityType: json['identityType'] as String?,
    identityNumber: json['identityNumber'] as String?,
    identityImage: json['identityImage'] as String?,
    roleId: json['roleId'] as String?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    // role: json['role'] as Map<String, dynamic>?,
    // vendorProfile: json['vendorProfile'] as Map<String, dynamic>?,
    assignedVendorId: json['assignedVendorId'] as String?,
    // deliveryManProfile: json['deliveryManProfile'] as Map<String, dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'status': status,
    'type': type,
    'avatar': avatar,
    'phone': phone,
    'googleProviderId': googleProviderId,
    'facebookProviderId': facebookProviderId,
    'appleProviderId': appleProviderId,
    'identityType': identityType,
    'identityNumber': identityNumber,
    'identityImage': identityImage,
    'roleId': roleId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    //'role': role,
    //'vendorProfile': vendorProfile,
    //'assignedVendorId': assignedVendorId,
    //'deliveryManProfile': deliveryManProfile,
  };
}
