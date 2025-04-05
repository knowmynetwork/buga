class RouteModel {
  final String fromAddressId;
  final String toAddressId;
  final double amount;
  final List<String> daysOfTravel;

  RouteModel({
    required this.fromAddressId,
    required this.toAddressId,
    required this.amount,
    required this.daysOfTravel,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      fromAddressId: json['fromAddressId'],
      toAddressId: json['toAddressId'],
      amount: json['amount'].toDouble(),
      daysOfTravel: List<String>.from(json['daysOfTravel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromAddressId': fromAddressId,
      'toAddressId': toAddressId,
      'amount': amount,
      'daysOfTravel': daysOfTravel,
    };
  }
}