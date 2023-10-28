/// id : 1
/// name : "Leanne Graham"
/// username : "Bret"
/// email : "Sincere@april.biz"
/// address : " quan 1, hcm"
/// phone : "1-770-736-8031 x56442"
/// website : "hildegard.org"

class UserModel {
  UserModel({
      int? id, 
      String? name, 
      String? username, 
      String? email, 
      String? address, 
      String? phone, 
      String? website, 
      }){
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _address = address;
    _phone = phone;
    _website = website;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _address = json['address'] ;
    _phone = json['phone'];
    _website = json['website'];
  }
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  String? _address;
  String? _phone;
  String? _website;

  int? get id => _id;
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  String? get address => _address;
  String? get phone => _phone;
  String? get website => _website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['address'] = _address;
    map['phone'] = _phone;
    map['website'] = _website;
    return map;
  }

}