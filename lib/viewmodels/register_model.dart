class RegisterModel {
  final String email;
  final String name;
  final String number;
  final String altNumber;
  final String password;
  final String comPassword;
  final String? otp;
  final String? address;
  final String? city;
  final String? state;
  final String? category;
  // /////// emergency contact
  final String? eName;
  final String? eRelationShip;
  final String? eNumber;
  final String? eAltNumber;

  RegisterModel(
    this.email,
    this.name,
    this.number,
    this.altNumber,
    this.password,
    this.comPassword,
    [this.otp,
    this.address,
    this.city,
    this.state,
    this.category,
    this.eName,
    this.eRelationShip,
    this.eNumber,
    this.eAltNumber,]
);

  // RegisterModel(
  //   this.email,
  //   this.name,
  //   this.number,
  //   this.altNumber,
  //   this.password,
  //   this.comPassword,
  //   this.otp,
  //   this.address,
  //   this.city,
  //   this.state,
  //   this.category,
  //   this.eName,
  //   this.eRelationShip,
  //   this.eNumber,
  //   this.eAltNumber,
  // );

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': number,
      'alternativePhoneNumber': altNumber,
      'password': password,
      'confirmPassword': comPassword,
      'otp': otp,
      'address': address,
      'city': city,
      'state': state,
      'category': category,
      'emergencyContact': {
        // Added emergencyContact object
        'name': eName,
        'relationship': eRelationShip,
        'phoneNumber': eNumber,
        'alternativePhoneNumber': eAltNumber,
      }
    };
  }
}


