class UserUpdateParam {
  final String uid;
  final String? email;
  final String? password;
  final String? fName;
  final String? lName;
  final bool? isAvailable;
  final String? role;

  UserUpdateParam({
    required this.uid,
    this.email,
    this.password,
    this.fName,
    this.lName,
    this.isAvailable,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'first_name': fName,
      'last_name': lName,
      'is_available': isAvailable,
      'role': role,
    };
  }
}
