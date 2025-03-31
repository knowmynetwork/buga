class AddSavedPlace {
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final String type;
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

  AddSavedPlace({
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
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
  });

  factory AddSavedPlace.fromJson(Map<String, dynamic> json) {
    return AddSavedPlace(
      title: json['title'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      type: json['type'],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "type": type,
      "name": name,
      "raw": raw,
      "adminArea": adminArea,
      "countryName": countryName,
      "countryCode": countryCode,
      "locality": locality,
      "subAdminArea": subAdminArea,
      "subLocality": subLocality,
      "postalCode": postalCode,
      "cityName": cityName,
      "addressFullName": addressFullName,
      "neighbourhood": neighbourhood,
      "streetName": streetName,
      "featureName": featureName,
    };
  }
}
