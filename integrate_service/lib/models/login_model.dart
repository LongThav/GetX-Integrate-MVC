
class LoginModel {
    String code;
    String message;
    Data data;

    LoginModel({
         this.code = "no-code",
         this.message = "no-message",
        required this.data,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String tokenType;
    String accessToken;
    User user;

    Data({
         this.tokenType = "no-tokentype",
         this.accessToken = "no-accesstoken",
        required this.user,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "access_token": accessToken,
        "user": user.toJson(),
    };
}

class User {
    int id;
    String name;
    String email;
    String? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
         this.id = 0,
         this.name = "no-name",
         this.email = "no-email",
        this.emailVerifiedAt,
         this.createdAt,
         this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
