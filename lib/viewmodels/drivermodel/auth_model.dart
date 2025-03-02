

class RegisterModel {
  final String name;
  final String email;
  final String number;
  final String altNumber;
  final String address;
  final String city;
  final String state;
  final String password;
  final String comPassword;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.number,
      required this.altNumber,
      required this.address,
      required this.city,
      required this.state,
      required this.password,
      required this.comPassword});
}
