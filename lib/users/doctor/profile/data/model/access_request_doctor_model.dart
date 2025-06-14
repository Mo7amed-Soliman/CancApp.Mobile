class AccessRequestDoctorModel {
  final String name;
  final String address;
  final String image;
  final String userId;

  AccessRequestDoctorModel({
    required this.name,
    required this.address,
    required this.image,
    required this.userId,
  });

  factory AccessRequestDoctorModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestDoctorModel(
      name: json['name'],
      address: json['address'],
      image: json['image'],
      userId: json['id'],
    );
  }
}
