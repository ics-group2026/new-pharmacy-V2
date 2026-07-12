class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String type;
  final String? roleId;
  final String? role;
  final String status;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.type,
    this.roleId,
    this.role,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    type: json['type'] as String,
    roleId: json['roleId'] as String?,
    role: json['role'] as String?,
    status: json['status'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'type': type,
    'roleId': roleId,
    'role': role,
    'status': status,
  };
}
