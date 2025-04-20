class Pharmacy {
  final String name;
  final String imageUrl;
  final bool isOpen;
  final String openUntil;
  final bool isDelivery;
  final String address;
  final PharmacyLocation location;

  const Pharmacy({
    required this.name,
    required this.imageUrl,
    required this.isOpen,
    required this.openUntil,
    required this.isDelivery,
    required this.address,
    required this.location,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      isOpen: json['is_open'] as bool,
      openUntil: json['open_until'] as String,
      isDelivery: json['is_delivery'] as bool,
      address: json['address'] as String,
      location:
          PharmacyLocation.fromJson(json['location'] as Map<String, dynamic>),
    );
  }
}

class PharmacyLocation {
  final double latitude;
  final double longitude;

  const PharmacyLocation({
    required this.latitude,
    required this.longitude,
  });

  factory PharmacyLocation.fromJson(Map<String, dynamic> json) {
    return PharmacyLocation(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}
