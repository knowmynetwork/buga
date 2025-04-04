class SavedPlaceResponse {
  final List<SavedPlace> data;
  final String message;
  final bool status;

  SavedPlaceResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SavedPlaceResponse.fromJson(Map<String, dynamic> json) {
    return SavedPlaceResponse(
      data: (json['data'] as List).map((e) => SavedPlace.fromJson(e)).toList(),
      message: json['message'] ?? "",
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.map((e) => e.toJson()).toList(),
      "message": message,
      "status": status,
    };
  }
}

class SavedPlace {
  final DateTime dateCreated;
  final DateTime? dateModified;
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

  SavedPlace({
    required this.dateCreated,
    this.dateModified,
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

  factory SavedPlace.fromJson(Map<String, dynamic> json) {
    return SavedPlace(
      dateCreated: DateTime.parse(json['dateCreated']),
      dateModified: json['dateModified'] != null
          ? DateTime.tryParse(json['dateModified'])
          : null,
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
      "dateCreated": dateCreated.toIso8601String(),
      "dateModified": dateModified?.toIso8601String(),
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