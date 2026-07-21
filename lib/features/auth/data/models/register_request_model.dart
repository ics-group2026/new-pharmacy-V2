import 'device_info_model.dart';

class RegisterRequestModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final DeviceInfoModel? device;

  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.device,
  });

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    if (device != null) "device": device!.toJson(),
  };
}
