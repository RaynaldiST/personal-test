class User {
  late String? id;
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? dob;
  late String? group;
  late String? initialName;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.group,
    this.initialName,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data["id"] ?? '',
        firstName: data["firstName"] ?? '',
        lastName: data["lastName"] ?? '',
        email: data["email"] ?? '',
        dob: data["dob"] ?? '',
        group: data["group"] ?? '',
        initialName: data["initialName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id!,
        "firstName": firstName!,
        "lastName": lastName!,
        "email": email!,
        "dob": dob!,
        "group": group!,
        "initialName": initialName!,
      };
}
