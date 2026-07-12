class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  Map<String, String> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
  };
}
