import 'locarion.dart';

class User {
  final String name;
  final String email;
  final String gender;
  final String phoneNumber;
  final int birthDate;
  final Location location;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String title;
  final String picture;
  final String uuid;
  final String firebaseToken;

  User(this.name, this.email, this.gender, this.phoneNumber,
      this.birthDate, this.location, this.username, this.password, this.firstname,
      this.lastname, this.title, this.picture, this.uuid, this.firebaseToken);
}