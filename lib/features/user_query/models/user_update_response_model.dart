class UserUpdateResponseModel {
  int? status;
  String? message;
  UserUpdateData? data;

  UserUpdateResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      UserUpdateResponseModel(
        status: json["status"],
        message: json["message"],
        data: UserUpdateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserUpdateData {
  int? id;
  String? name;
  String? email;
  String? username;
  String? password;
  bool? verified;
  String? position;
  String? phone;
  String? profilePicture;
  dynamic rememberToken;
  String? createdAt;
  String? updatedAt;

  UserUpdateData({
    this.id,
    this.name,
    this.email,
    this.username,
    this.password,
    this.verified,
    this.position,
    this.phone,
    this.profilePicture,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  factory UserUpdateData.fromJson(Map<String, dynamic> json) => UserUpdateData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        verified: json["verified"],
        position: json["position"],
        phone: json["phone"],
        profilePicture: json["profile_picture"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "verified": verified,
        "position": position,
        "phone": phone,
        "profile_picture": profilePicture,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
