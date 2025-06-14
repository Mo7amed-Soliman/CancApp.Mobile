class NearestPharmacyModel {
  final String name;
  final String image;
  final bool isDeliveryEnabled;
  final double latitude;
  final double longitude;
  final bool isOpeningNow;
  final String address;

  NearestPharmacyModel({
    required this.name,
    required this.image,
    required this.isDeliveryEnabled,
    required this.latitude,
    required this.longitude,
    required this.isOpeningNow,
    required this.address,
  });

  factory NearestPharmacyModel.fromJson(Map<String, dynamic> json) {
    return NearestPharmacyModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isDeliveryEnabled: json['isDeliveryEnabled'] ?? false,
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      isOpeningNow: json['isOpeningNow'] ?? false,
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'isDeliveryEnabled': isDeliveryEnabled,
        'latitude': latitude,
        'longitude': longitude,
        'isOpeningNow': isOpeningNow,
      };
}
