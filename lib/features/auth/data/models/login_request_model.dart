import 'device_info_model.dart';

class LoginRequestModel {
  final String email;
  final String password;
  final DeviceInfoModel? device;

  LoginRequestModel({required this.email, required this.password, this.device});

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    if (device != null) "device": device!.toJson(),
  };
}
