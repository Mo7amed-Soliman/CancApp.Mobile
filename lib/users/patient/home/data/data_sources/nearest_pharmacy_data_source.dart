import 'package:canc_app/users/patient/home/data/models/pharmacy_model.dart';
import 'package:dio/dio.dart';

abstract class NearestPharmacyDataSource {
  Future<List<Pharmacy>> getNearestPharmacies();
}

class NearestPharmacyDataSourceImpl implements NearestPharmacyDataSource {
  final Dio dio;

  NearestPharmacyDataSourceImpl({required this.dio});

  @override
  Future<List<Pharmacy>> getNearestPharmacies() async {
    await Future.delayed(const Duration(seconds: 2));

    final pharmacies = [
      const Pharmacy(
        name: 'Wiqaya Pharmacies',
        imageUrl:
            'https://public.readdy.ai/ai/img_res/1205ea3773666916aefa64a58ac9cadd.jpg',
        isOpen: false,
        openUntil: '12:00',
        isDelivery: true,
        address: 'Al-Firdaws, Fayoum, Egypt',
        location: PharmacyLocation(latitude: 29.3100, longitude: 30.8400),
      ),
      const Pharmacy(
        name: 'Abdel Motaal Pharmacy',
        imageUrl:
            'https://public.readdy.ai/ai/img_res/d4b60e6525801f9203d11a39627a94c1.jpg',
        isOpen: true,
        openUntil: '24h',
        isDelivery: false,
        address: 'Gonaidy Street, Fayoum',
        location: PharmacyLocation(latitude: 29.3100, longitude: 30.8400),
      ),
      const Pharmacy(
        name: 'Mohamed Samir Pharmacy',
        imageUrl:
            'https://public.readdy.ai/ai/img_res/1205ea3773666916aefa64a58ac9cadd.jpg',
        isOpen: true,
        openUntil: '24h',
        isDelivery: true,
        address: 'Dar El-Ramad El-Gedid Street, Fayoum',
        location: PharmacyLocation(latitude: 29.3100, longitude: 30.8400),
      ),
      const Pharmacy(
        name: 'Ahmed Rahmy Pharmacy',
        imageUrl:
            'https://public.readdy.ai/ai/img_res/d4b60e6525801f9203d11a39627a94c1.jpg',
        isOpen: true,
        openUntil: '24h',
        isDelivery: true,
        address: 'El-Saidi District, Fayoum',
        location: PharmacyLocation(latitude: 29.3100, longitude: 30.8400),
      ),
    ];

    return pharmacies;

    // try {
    // TODO: Replace with actual API endpoint
    // final response = await dio.get('/api/pharmacies/nearest');

    //   if (response.statusCode == 200) {
    //     final List<dynamic> data = response.data['data'];
    //     return data.map((json) => Pharmacy.fromJson(json)).toList();
    //   } else {
    //     throw Exception('Failed to load pharmacies');
    //   }
    // } catch (e) {
    //   throw Exception('Error fetching pharmacies: $e');
    // }
  }
}
