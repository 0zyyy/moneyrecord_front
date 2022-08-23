class User {
  String? idUser;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;

  User(
      {this.idUser,
        this.name,
        this.email,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
