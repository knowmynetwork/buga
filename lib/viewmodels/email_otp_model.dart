class GetEmailModel {
  final String eMail;

  GetEmailModel({required this.eMail});

  Map<String, dynamic> toJson() {
    return {
      'email': eMail,
    };
  }
}

class VerifiedEmailOtpModel {
  final String eMail;
  final String tokenOtp;

  VerifiedEmailOtpModel({required this.eMail, required this.tokenOtp});


  Map<String, dynamic> toJson() {
    return {
      'email': eMail,
      "token": tokenOtp,
    };
  }
}
