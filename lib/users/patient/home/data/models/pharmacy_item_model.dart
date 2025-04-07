/// Model for pharmacy items in the nearest pharmacy section
class PharmacyItemModel {
  /// The image URL or path for the pharmacy
  final String image;

  /// The name of the pharmacy
  final String name;

  /// Creates a pharmacy item model
  const PharmacyItemModel({
    required this.image,
    required this.name,
  });
}
