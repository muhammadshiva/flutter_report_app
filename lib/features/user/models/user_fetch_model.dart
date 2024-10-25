class UserFetchResponseModel {
  int? status;
  String? message;
  List<UserData>? data;

  UserFetchResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserFetchResponseModel.fromJson(Map<String, dynamic> json) =>
      UserFetchResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserData {
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
