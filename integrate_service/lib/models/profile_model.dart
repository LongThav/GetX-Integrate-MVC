class ProfleModel {
    List<Profile> data;

    ProfleModel({
         this.data = const [],
    });

    factory ProfleModel.fromJson(Map<String, dynamic> json) => ProfleModel(
        data: List<Profile>.from(json["data"].map((x) => Profile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Profile {
    int? id;
    String? name;
    String? email;
    String? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    Profile({
         this.id,
         this.name,
         this.email,
        this.emailVerifiedAt,
         this.createdAt,
         this.updatedAt,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
