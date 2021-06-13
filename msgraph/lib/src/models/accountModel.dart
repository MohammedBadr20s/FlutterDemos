



class AccountModel {
  final String email;
  final String name;
  AccountModel({this.email, this.name});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
  factory AccountModel.fromJson(Map<dynamic, dynamic> json) => AccountModel(
    name: json["name"],
    email: json["email"],
  );
}