class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String phoneNumber;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = firstName;
    _data['email'] = lastName;
    _data['gender'] = phoneNumber;
    return _data;
  }
}