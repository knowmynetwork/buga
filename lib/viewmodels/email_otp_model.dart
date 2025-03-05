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

  VerifiedEmailOtpModel(this.tokenOtp, {required this.eMail});

  Map<String, dynamic> toJson() {
    return {
      'email': eMail,
      "token": tokenOtp,
    };
  }
}
