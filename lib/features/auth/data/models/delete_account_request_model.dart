class DeleteAccountRequestModel {
  final String currentPassword;

  DeleteAccountRequestModel({required this.currentPassword});

  Map<String, dynamic> toJson() => {"currentPassword": currentPassword};
}
