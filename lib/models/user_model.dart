class UserModel {
  final String? id;
  final String? firtname;
  final String? lastname;
  final String? email;

  UserModel({this.id, this.firtname, this.lastname, this.email});

  Map<String, dynamic> toMap() => {
        'firtname': firtname,
        'lastname': lastname,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> value) => UserModel(
        id: value['id'],
        firtname: value['firtname'],
        lastname: value['lastname'],
        email: value['email'],
      );
}
