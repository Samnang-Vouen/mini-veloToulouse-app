import 'package:velotoulouse/model/user/user.dart';

class UserDto {
  static final String idKey = 'id';
  static final String nameKey = 'name';
  static final String emailKey = 'email';

  static User fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);

    return User(
      id: json[idKey] as String,
      name: json[nameKey] as String? ?? '',
      email: json[emailKey] as String? ?? '',
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {idKey: user.id, nameKey: user.name, emailKey: user.email};
  }
}
