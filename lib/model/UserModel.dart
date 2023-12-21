class ListUser {
  List<UserModel>? users;
  ListUser({this.users});
  ListUser.fromMap({required List<Map<dynamic, dynamic>> map}) {
    users = [];
    for (var v in map) {
      users!.add(UserModel.fromMap(map: v));
    }
  }
}

class UserModel {
  String? name;
  String? password;
  String? phoneNumber;

  UserModel({this.name, this.password, this.phoneNumber});

  UserModel.fromMap({required Map<dynamic, dynamic> map}) {
    name = map["name"];
    password = map["password"];
    phoneNumber = map["phone"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["password"] = password;
    data["phone"] = phoneNumber;
    return data;
  }
}
