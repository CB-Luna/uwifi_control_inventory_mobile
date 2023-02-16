import 'dart:convert';

ResponseLoginSupabase responseLoginSupabaseFromMap(String str) => ResponseLoginSupabase.fromMap(json.decode(str));

String responseLoginSupabaseToMap(ResponseLoginSupabase data) => json.encode(data.toMap());

class ResponseLoginSupabase {
    ResponseLoginSupabase({
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
        required this.refreshToken,
        required this.user,
    });

    final String accessToken;
    final String tokenType;
    final int expiresIn;
    final String refreshToken;
    final User user;

    factory ResponseLoginSupabase.fromMap(Map<String, dynamic> json) => ResponseLoginSupabase(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        refreshToken: json["refresh_token"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "refresh_token": refreshToken,
        "user": user.toMap(),
    };
}

class User {
    User({
        required this.id,
        required this.aud,
        required this.role,
        required this.email,
        required this.emailConfirmedAt,
        required this.phone,
        required this.confirmedAt,
        required this.lastSignInAt,
        required this.appMetadata,
        required this.userMetadata,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String aud;
    final String role;
    final String email;
    final DateTime emailConfirmedAt;
    final String? phone;
    final DateTime confirmedAt;
    final DateTime lastSignInAt;
    final AppMetadata appMetadata;
    final UserMetadata userMetadata;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        aud: json["aud"],
        role: json["role"],
        email: json["email"],
        emailConfirmedAt: DateTime.parse(json["email_confirmed_at"]),
        phone: json["phone"],
        confirmedAt: DateTime.parse(json["confirmed_at"]),
        lastSignInAt: DateTime.parse(json["last_sign_in_at"]),
        appMetadata: AppMetadata.fromMap(json["app_metadata"]),
        userMetadata: UserMetadata.fromMap(json["user_metadata"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "aud": aud,
        "role": role,
        "email": email,
        "email_confirmed_at": emailConfirmedAt.toIso8601String(),
        "phone": phone,
        "confirmed_at": confirmedAt.toIso8601String(),
        "last_sign_in_at": lastSignInAt.toIso8601String(),
        "app_metadata": appMetadata.toMap(),
        "user_metadata": userMetadata.toMap(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class AppMetadata {
    AppMetadata({
        required this.provider,
        required this.providers,
    });

    final String provider;
    final List<String> providers;

    factory AppMetadata.fromMap(Map<String, dynamic> json) => AppMetadata(
        provider: json["provider"],
        providers: List<String>.from(json["providers"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "provider": provider,
        "providers": List<dynamic>.from(providers.map((x) => x)),
    };
}


class UserMetadata {
    UserMetadata();

    factory UserMetadata.fromMap(Map<String, dynamic> json) => UserMetadata(
    );

    Map<String, dynamic> toMap() => {
    };
}
