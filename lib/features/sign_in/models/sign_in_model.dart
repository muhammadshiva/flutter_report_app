class SignInResponseModel {
  int? status;
  String? message;
  SignInData? data;

  SignInResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : SignInData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class SignInData {
  int? id;
  String? name;
  String? email;
  String? username;
  String? password;
  dynamic verified;
  String? position;
  String? phone;
  String? profilePicture;
  dynamic rememberToken;
  String? createdAt;
  String? updatedAt;
  String? token;
  int? tokenExpiresIn;
  String? tokenType;

  SignInData({
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
    this.tokenExpiresIn,
    this.tokenType,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
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
        tokenExpiresIn: json["token_expires_in"],
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
        "token_expires_in": tokenExpiresIn,
        "token_type": tokenType,
      };
}
