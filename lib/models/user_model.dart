import 'dart:convert';

class UserModel {
  String name;
  bool isEmailVerified;
  String email;
  String id;
  String imageUrl;

  UserModel({
    required this.name,
    required this.isEmailVerified,
    required this.email,
    required this.id,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      name: jsonData['name'],
      isEmailVerified: jsonData['isEmailVerified'],
      email: jsonData['email'],
      id: jsonData['id'],
      imageUrl: jsonData['imageUrl'],
    );
  }

  static Map<String, dynamic> toMap(UserModel model) => {
        'name': model.name,
        'isEmailVerified': model.isEmailVerified,
        'email': model.email,
        'id': model.id,
        'imageUrl': model.imageUrl,
      };

  static String serialize(UserModel model) =>
      json.encode(UserModel.toMap(model));

  static Future<UserModel> deserialize(String json) => Future.delayed(
      const Duration(seconds: 1), () => UserModel.fromJson(jsonDecode(json)));

  static UserModel deserializeFast(String json) =>
      UserModel.fromJson(jsonDecode(json));
}
