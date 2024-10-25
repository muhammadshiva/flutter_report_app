class UserPostResponseModel {
  int? status;
  String? message;
  UserData? data;

  UserPostResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserPostResponseModel.fromJson(Map<String, dynamic> json) =>
      UserPostResponseModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? username;
  String? password;
  bool? verified;
  String? position;
  String? phone;
  String? profilePicture;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? tokenType;

  UserData({
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
    this.token,
    this.tokenType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        token: json["token"],
        tokenType: json["token_type"],
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
        "token": token,
        "token_type": tokenType,
      };
}
