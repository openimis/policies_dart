class BearerToken {
  final String _token;
  final num _expiry;

  BearerToken(this._token, this._expiry);

  BearerToken.fromJson(Map<String, dynamic> json)
      : _token = json['token'],
        _expiry = json['exp'];

  Map<String, dynamic> toJson() => {'token': _token, 'exp': _expiry};

  num expiresIn() {
    //Token expires in the next 2 seconds or is already expired
    return _expiry - (DateTime.now().microsecondsSinceEpoch / 1000);
  }

  String getToken() => _token;
}
