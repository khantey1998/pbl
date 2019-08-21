
class User {
//  String _email;
//  String _password;
//  User(this._email, this._password);
//
//  User.map(dynamic obj) {
//    this._email = obj["email"];
//    this._password = obj["password"];
//  }
//
//  String get email => _email;
//  String get password => _password;
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["email"] = _email;
//    map["password"] = _password;
//
//    return map;
//  }
  int id;
  final String email;
  final String password;
  final String rememberToken;

  User({this.id,this.email, this.password, this.rememberToken});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'] ,
      email: parsedJson['email'] as String,
      password: parsedJson['password'] as String,
      rememberToken: parsedJson['access_token'] as String,
    );
  }
  Map toMap(){
    var map = Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}
