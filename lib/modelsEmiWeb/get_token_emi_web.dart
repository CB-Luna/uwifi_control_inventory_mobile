import 'dart:convert';

GetTokenEmiWeb getTokenEmiWebFromMap(String str) => GetTokenEmiWeb.fromMap(json.decode(str));

String getTokenEmiWebToMap(GetTokenEmiWeb data) => json.encode(data.toMap());

class GetTokenEmiWeb {
    GetTokenEmiWeb({
        required this.accessToken,
        required this.tokenType,
        required this.refreshToken,
        required this.expiresIn,
        required this.scope,
    });

    final String accessToken;
    final String tokenType;
    final String refreshToken;
    final int expiresIn;
    final String scope;

    factory GetTokenEmiWeb.fromMap(Map<String, dynamic> json) => GetTokenEmiWeb(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
        scope: json["scope"],
    );

    Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
        "scope": scope,
    };
}
