import 'dart:convert';

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
      message: json['message'],
      status: json['status'],
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
  final String id;
  final DateTime dateCreated;
  final DateTime dateModified;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final String type;

  SavedPlace({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  factory SavedPlace.fromJson(Map<String, dynamic> json) {
    return SavedPlace(
      id: json['id'],
      dateCreated: DateTime.parse(json['dateCreated']),
      dateModified: DateTime.parse(json['dateModified']),
      title: json['title'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "dateCreated": dateCreated.toIso8601String(),
      "dateModified": dateModified.toIso8601String(),
      "title": title,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "type": type,
    };
  }
}
