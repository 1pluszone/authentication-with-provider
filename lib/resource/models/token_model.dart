class TokenModel {
  final String token;

  TokenModel({this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(token: json['token'] as String);
  }
}
