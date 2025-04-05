class RouteResponse {
  final List<RouteData> data;
  final String message;
  final bool status;

  RouteResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      data: (json['data'] as List).map((e) => RouteData.fromJson(e)).toList(),
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
      'status': status,
    };
  }
}

class RouteData {
  final String id;
  final Address fromAddress;
  final Address toAddress;
  final double amount;
  final List<String> daysOfTravel;
  final DateTime dateCreated;

  RouteData({
    required this.id,
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
    required this.daysOfTravel,
    required this.dateCreated,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    return RouteData(
      id: json['id'],
      fromAddress: Address.fromJson(json['fromAddress']),
      toAddress: Address.fromJson(json['toAddress']),
      amount: json['amount'].toDouble(),
      daysOfTravel: List<String>.from(json['daysOfTravel']),
      dateCreated: DateTime.parse(json['dateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromAddress': fromAddress.toJson(),
      'toAddress': toAddress.toJson(),
      'amount': amount,
      'daysOfTravel': daysOfTravel,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }
}

class Address {
  final String id;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final String name;
  final String raw;
  final String adminArea;
  final String countryName;
  final String countryCode;
  final String locality;
  final String subAdminArea;
  final String subLocality;
  final String postalCode;
  final String cityName;
  final String addressFullName;
  final String neighbourhood;
  final String streetName;
  final String featureName;
  final String type;

  Address({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.raw,
    required this.adminArea,
    required this.countryName,
    required this.countryCode,
    required this.locality,
    required this.subAdminArea,
    required this.subLocality,
    required this.postalCode,
    required this.cityName,
    required this.addressFullName,
    required this.neighbourhood,
    required this.streetName,
    required this.featureName,
    required this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateModified: DateTime.parse(json['dateModified']),
      title: json['title'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      name: json['name'],
      raw: json['raw'],
      adminArea: json['adminArea'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      locality: json['locality'],
      subAdminArea: json['subAdminArea'],
      subLocality: json['subLocality'],
      postalCode: json['postalCode'],
      cityName: json['cityName'],
      addressFullName: json['addressFullName'],
      neighbourhood: json['neighbourhood'],
      streetName: json['streetName'],
      featureName: json['featureName'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateCreated': dateCreated.toIso8601String(),
      'dateModified': dateModified.toIso8601String(),
      'title': title,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'raw': raw,
      'adminArea': adminArea,
      'countryName': countryName,
      'countryCode': countryCode,
      'locality': locality,
      'subAdminArea': subAdminArea,
      'subLocality': subLocality,
      'postalCode': postalCode,
      'cityName': cityName,
      'addressFullName': addressFullName,
      'neighbourhood': neighbourhood,
      'streetName': streetName,
      'featureName': featureName,
      'type': type,
    };
  }
}