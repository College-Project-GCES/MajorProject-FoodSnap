import 'dart:convert';

class UserModel {
  String name;
  bool isEmailVerified;
  String email;
  String id;

  UserModel({
    required this.name,
    required this.isEmailVerified,
    required this.email,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['name'],
      isEmailVerified: jsonData['isEmailVerified'],
      email: jsonData['email'],
      id: jsonData['id'],
    );
  }

  static Map<String, dynamic> toMap(UserModel model) => {
        'isEmailVerified': model.isEmailVerified,
        'email': model.email,
        'id': model.id,
        'name': model.name,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static Future<UserModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1), () => UserModel.fromJson(jsonDecode(json)));

  static UserModel deserializeFast(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
