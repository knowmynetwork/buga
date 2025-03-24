class AzureMapResult {
  final String id;
  final String freeformAddress;
  final double lat;
  final double lon;

  AzureMapResult({
    required this.id,
    required this.freeformAddress,
    required this.lat,
    required this.lon,
  });

  factory AzureMapResult.fromJson(Map<String, dynamic> json) {
    return AzureMapResult(
      id: json['id'] ?? '',
      freeformAddress: json['address']['freeformAddress'] ?? '',
      lat: json['position']['lat']?.toDouble() ?? 0.0,
      lon: json['position']['lon']?.toDouble() ?? 0.0,
    );
  }
}
