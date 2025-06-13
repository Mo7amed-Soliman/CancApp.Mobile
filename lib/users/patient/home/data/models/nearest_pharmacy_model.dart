class NearestPharmacyModel {
  final String name;
  final String image;
  final bool isDeliveryEnabled;
  final bool isOpeningNow;
  final double latitude;
  final double longitude;

  const NearestPharmacyModel({
    required this.name,
    required this.image,
    required this.isDeliveryEnabled,
    required this.isOpeningNow,
    required this.latitude,
    required this.longitude,
  });

  factory NearestPharmacyModel.fromJson(Map<String, dynamic> json) {
    return NearestPharmacyModel(
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isDeliveryEnabled: json['isDeliveryEnabled'] as bool? ?? false,
      isOpeningNow: json['isOpeningNow'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
