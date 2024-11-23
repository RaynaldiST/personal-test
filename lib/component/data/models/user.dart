class User {
  late String? id;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? dob;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data["id"] ?? '',
        firstName: data["firstName"] ?? '',
        lastName: data["lastName"] ?? '',
        email: data["email"] ?? '',
        dob: data["dob"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "firstName": firstName!,
        "lastName": lastName!,
        "email": email!,
        "dob": dob!,
      };
}
