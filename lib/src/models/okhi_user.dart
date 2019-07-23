import 'package:meta/meta.dart';

class OkHiUser {
  final String phone;
  final String firstName;
  final String lastName;

  OkHiUser({
    @required this.phone,
    this.firstName,
    this.lastName,
  });

  OkHiUser.fromJSON(Map<String, dynamic> parsedJSON)
      : this.phone = parsedJSON['phone'],
        this.firstName = parsedJSON['firstName'],
        this.lastName = parsedJSON['lastName'];

  Map<String, String> toJSON() {
    final Map<String, String> user = {
      "phone": phone,
    };
    if (firstName != null) user["firstName"] = firstName;
    if (lastName != null) user["lastName"] = lastName;
    return user;
  }
}
